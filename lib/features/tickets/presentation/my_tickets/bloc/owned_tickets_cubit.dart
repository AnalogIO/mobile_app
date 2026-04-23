// owned_tickets_cubit.dart
import 'dart:async';

import 'package:cafe_analog_app/features/tickets/data/tickets_repository.dart';
import 'package:cafe_analog_app/features/tickets/models/owned_ticket_group.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'owned_tickets_state.dart';

/// Cubit responsible for managing the state of the user's owned tickets,
/// including fetching from API and cache, refreshing, reordering,
/// and dismissing depleted tickets.
///
/// The cubit treats the cached tickets as the source of truth for the user's
/// preferred order of their tickets, and therefore always preserves this order
/// when fetching fresh tickets from the API.
class OwnedTicketsCubit extends Cubit<OwnedTicketsState> {
  OwnedTicketsCubit({required TicketsRepository repository})
    : _repository = repository,
      super(OwnedTicketsInitial());

  final TicketsRepository _repository;

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
    await for (final result in _repository.getOwnedTickets()) {
      emit(
        result.match(
          (failure) => OwnedTicketsFailure(reason: failure.reason),
          (ownedTickets) => OwnedTicketsLoaded(ownedTickets: ownedTickets),
        ),
      );
    }
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
        return _repository
            .refreshOwnedTickets(preferredOrder: ownedTickets)
            .match(
              (failure) => emit(OwnedTicketsFailure(reason: failure.reason)),
              (refreshedOwnedTickets) => emit(
                OwnedTicketsLoaded(ownedTickets: refreshedOwnedTickets),
              ),
            )
            .run();
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
    return _repository
        .saveOwnedTicketsOrder(updatedTickets)
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

    final cacheResult = await _repository
        .saveOwnedTicketsOrder(updatedTickets)
        .match(
          (didNotCache) => OwnedTicketsFailure(reason: didNotCache.reason),
          (_) => OwnedTicketsLoaded(ownedTickets: updatedTickets),
        )
        .run();

    emit(cacheResult);
  }
}
