import 'dart:async';

import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_repository.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'owned_tickets_state.dart';

/// Cubit responsible for managing the state of the user's owned tickets,
/// including fetching from API and cache, refreshing, reordering,
/// and dismissing depleted tickets.
/// 
/// The cubit treats the cached tickets as the source of truth for the user's
/// preferred order of their tickets, and therefore always preserves this order
/// when fetching fresh tickets from the API.
class OwnedTicketsCubit extends Cubit<OwnedTicketsState> {
  OwnedTicketsCubit({
    required OwnedTicketsRepository ownedTicketsRepository,
  }) : _ownedTicketsRepository = ownedTicketsRepository,
       super(OwnedTicketsInitial());

  final OwnedTicketsRepository _ownedTicketsRepository;

  /// Gets owned tickets when they are not already loaded.
  ///
  /// Does nothing if tickets are already loaded;
  /// in that case, use [refreshOwnedTickets] to fetch fresh tickets.
  Future<void> getOwnedTickets() async {
    final state = this.state;

    // If tickets are already loaded, do nothing
    if (state is OwnedTicketsLoaded) {
      assert(
        false,
        'getOwnedTickets should not be called when tickets are already '
        'loaded; use refreshOwnedTickets instead',
      );
      return Future.value();
    }

    // If we are already loading, don't start another load
    if (state is OwnedTicketsLoading) {
      assert(
        false,
        'getOwnedTickets should not be called when tickets are already loading',
      );
      return Future.value();
    }

    emit(OwnedTicketsLoading());
    return _getOwnedTicketsFromCache().then((_) => _getOwnedTicketsFromApi());
  }

  /// Refreshes owned tickets when they are already loaded.
  ///
  /// Does nothing if tickets are not already loaded;
  /// in that case, use [getOwnedTickets] to fetch tickets.
  Future<void> refreshOwnedTickets() {
    switch (state) {
      case OwnedTicketsRefreshing():
        // Only allow one refresh at a time
        return Future.value();
      case OwnedTicketsLoaded(:final ownedTickets):
        emit(OwnedTicketsRefreshing(ownedTickets: ownedTickets));
        return _getOwnedTicketsFromApi();
      case _:
        assert(
          false,
          'refreshOwnedTickets should not be called when tickets are not '
          'already loaded; use getOwnedTickets instead',
        );
        return Future.value();
    }
  }

  /// Moves a ticket from [oldIndex] to [newIndex] in the user's owned tickets,
  /// then caches the updated tickets list.
  ///
  /// Accounts for the framework behaviour where `newIndex` is adjusted when
  /// moving downwards.
  Future<void> reorderTickets(int oldIndex, int newIndex) async {
    final state = this.state;
    // Cannot reorder tickets when tickets are not loaded
    if (state is! OwnedTicketsLoaded) {
      return;
    }

    final insertAtIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    final updatedTickets = List.of(state.ownedTickets);
    final ticket = updatedTickets.removeAt(oldIndex);
    updatedTickets.insert(insertAtIndex, ticket);

    // Optimistically emit the updated order to avoid UI jank...
    emit(OwnedTicketsLoaded(ownedTickets: updatedTickets));

    // ...then cache the tickets to persist the new preferred order.
    return _ownedTicketsRepository
        .cacheTickets(updatedTickets)
        .match(
          (didNotCache) =>
              emit(OwnedTicketsFailure(reason: didNotCache.reason)),
          // We already optimistically updated the order above,
          // so don't need to do anything on success
          (_) => null,
        )
        .run();
  }

  /// Removes a depleted entry from the user's owned tickets, then
  /// caches the updated tickets list.
  Future<void> dismissDepletedTicket(int productId) async {
    final state = this.state;
    if (state is! OwnedTicketsLoaded) {
      return;
    }

    final ticketToDismiss = state.ownedTickets
        .where((ticket) => ticket.productId == productId && ticket.isDepleted)
        .firstOrNull;

    if (ticketToDismiss == null) {
      // No depleted ticket with the given product id was found, so do nothing
      emit(
        OwnedTicketsFailure(
          reason: 'No depleted ticket with product id $productId found',
        ),
      );
      return;
    }

    final updatedTickets = state.ownedTickets
        .where((ownedTicket) => ownedTicket != ticketToDismiss)
        .toList();

    final cacheResult = await _ownedTicketsRepository
        .cacheTickets(updatedTickets)
        .match(
          (didNotCache) => OwnedTicketsFailure(reason: didNotCache.reason),
          (_) => OwnedTicketsLoaded(ownedTickets: updatedTickets),
        )
        .run();

    emit(cacheResult);
  }

  /// Get owned tickets from cache and emit [OwnedTicketsLoaded] if successful.
  /// Failures are silently ignored.
  ///
  /// The order of tickets in the emitted state represents the user's preferred
  /// order (if they have rearranged their tickets in the UI).
  Future<void> _getOwnedTicketsFromCache() async {
    await _ownedTicketsRepository
        .getTicketsFromCache()
        .chainFirst(
          (cachedTickets) => TaskEither.of(
            emit(OwnedTicketsLoaded(ownedTickets: cachedTickets)),
          ),
        )
        .run();
  }

  /// Fetch owned tickets from API and update the cache.
  ///
  /// If we already had cached tickets, we want to preserve the order of these,
  /// putting any new tickets from the API at the beginning of the list.
  /// This way, if the user has rearranged their tickets in a preferred order,
  /// we don't mess with this order when they refresh their tickets, while
  /// still showing any new tickets they have acquired.
  ///
  /// We also account for tickets that are in cache but not in fetched results.
  /// These represent "depleted" tickets where the last ticket has been used.
  /// If a ticket is depleted, we still include it in the results, setting its
  /// clips to 0 instead of removing it to allow the UI to show a special type
  /// of "depleted ticket card" in its place.
  Future<void> _getOwnedTicketsFromApi() async {
    final fetchResult = await _ownedTicketsRepository
        .fetchTicketsFromApi()
        .map((fetchedTickets) {
          // If we don't have cached tickets,
          // accept the fetched tickets in the order they come and return early
          final state = this.state;
          if (state is! OwnedTicketsLoaded) {
            return fetchedTickets;
          }

          final cachedTickets = state.ownedTickets;

          // Cached tickets that are not in fetched tickets (= depleted tickets)
          final depletedTickets = cachedTickets
              // We use differenceBy with equality based on product id only,
              // since the number of clips left on a ticket could differ between
              // cached and fetched tickets.
              .difference(Eq.by((t) => t.productId, Eq.eqInt), fetchedTickets)
              .map((ticket) => ticket.asDepleted());

          final allTickets = fetchedTickets.followedBy(depletedTickets);

          // Get preferred order from the cached tickets
          // as a map of (product id) -> (index in the preferred order)
          final preferredOrder = {
            for (final (preferredOrderIndex, ticket) in cachedTickets.indexed)
              ticket.productId: preferredOrderIndex,
          };

          // Sort tickets according to preferred order, putting tickets without
          // an order (= new tickets) at the beginning of the list
          return allTickets.sortedBy(
            (ticket) {
              return preferredOrder
                  .lookup(ticket.productId)
                  .getOrElse(() => -1);
            },
          );
        })
        // Cache the fetched/ordered tickets as a side effect
        // (but fail on caching errors)
        .flatMap(
          (ownedTickets) => _ownedTicketsRepository
              .cacheTickets(ownedTickets)
              .map((_) => ownedTickets),
        )
        .match(
          (didNotFetchOrCache) =>
              OwnedTicketsFailure(reason: didNotFetchOrCache.reason),
          (ownedTickets) => OwnedTicketsLoaded(ownedTickets: ownedTickets),
        )
        .run();

    emit(fetchResult);
  }
}
