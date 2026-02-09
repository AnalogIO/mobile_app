import 'dart:async';

import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'owned_tickets_state.dart';

class OwnedTicketsCubit extends Cubit<OwnedTicketsState> {
  OwnedTicketsCubit({
    required OwnedTicketsRepository ownedTicketsRepository,
  }) : _ownedTicketsRepository = ownedTicketsRepository,
       super(OwnedTicketsInitial());

  final OwnedTicketsRepository _ownedTicketsRepository;

  /// Fetches owned tickets, first from cache, then from API.
  ///
  /// When fetching from API, also updates the cache.
  Future<void> getOwnedTickets() async {
    // Don't emit loading if we are already loaded to avoid showing a spinner
    // on top of existing data. We continue to fetch in the background.
    if (state is! OwnedTicketsLoaded) {
      emit(OwnedTicketsLoading());
    }

    // FIXME(marfavi): Implement logic to apply preferred order to tickets
    // ignore: unused_local_variable
    final preferredOrder = await _ownedTicketsRepository
        // Attempt to get preferred order from storage
        .getTicketOrder()
        .getOrElse((_) => const [])
        .run();

    // First try to get cached tickets to show immediately
    await _ownedTicketsRepository
        .getTicketsFromCache()
        .chainFirst(
          (cachedTickets) => TaskEither.of(
            emit(OwnedTicketsLoaded(ownedTickets: cachedTickets)),
          ),
        )
        .run();

    // Then fetch fresh tickets from API
    final fetchResult = await _ownedTicketsRepository
        .fetchTicketsFromApi()
        // Sort tickets according to preferred order
        // .flatMap(
        //   (ownedTickets) => _ownedTicketsRepository.getTicketOrder()
        // )
        // On success, update the cache with the fetched tickets
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

  /// Moves a ticket from [oldIndex] to [newIndex] in the preferred order.
  ///
  /// Accounts for the framework behaviour where `newIndex` is adjusted when
  /// moving downwards.
  Future<void> reorderTickets(int oldIndex, int newIndex) async {
    final currentState = state;
    if (currentState is! OwnedTicketsLoaded) {
      return;
      // return emit(
      //   const OwnedTicketsFailure(
      //     reason: 'Cannot reorder tickets when tickets are not loaded',
      //   ),
      // );
    }

    final insertAtIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    final updatedTickets = List.of(currentState.ownedTickets);
    final ticket = updatedTickets.removeAt(oldIndex);
    updatedTickets.insert(insertAtIndex, ticket);

    // Optimistically emit the updated order to avoid UI jank
    emit(OwnedTicketsLoaded(ownedTickets: updatedTickets));

    return _ownedTicketsRepository
        .cacheTicketOrder(updatedTickets.map((x) => x.productId).toList())
        // .cacheTickets(updatedTickets)
        .match(
          (didNotUpdate) =>
              emit(OwnedTicketsFailure(reason: didNotUpdate.reason)),
          // We already optimistically updated the order above,
          // so don't need to do anything on success
          (_) => null,
        )
        .run();
  }

  /// Removes a depleted entry from the preferred order and the displayed list.
  Future<void> dismissDepletedTicket(int productId) async {
    throw UnimplementedError();
  }

  // FIXME(marfavi): Get loaded tickets from storage on startup
}
