import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/catalog/drink.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_local_data_provider.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_remote_data_provider.dart';
import 'package:fpdart/fpdart.dart';

class OwnedTicketsRepository {
  const OwnedTicketsRepository({
    required OwnedTicketsLocalDataProvider localDataProvider,
    required OwnedTicketsRemoteDataProvider remoteDataProvider,
  }) : _localDataProvider = localDataProvider,
       _remoteDataProvider = remoteDataProvider;

  final OwnedTicketsLocalDataProvider _localDataProvider;
  final OwnedTicketsRemoteDataProvider _remoteDataProvider;

  /// Fetch owned tickets from API in any order, with their eligible drinks
  /// assigned.
  TaskEither<Failure, List<OwnedTicket>> fetchTicketsFromApi() {
    return _remoteDataProvider.get().map(
      (dtos) => dtos
          .map(
            (dto) => OwnedTicket(
              productId: dto.productId,
              ticketName: dto.productName,
              ticketsLeft: dto.ticketsLeft,
              backgroundImagePath:
                  // choose background based on some rudimentary logic
                  dto.productName.toLowerCase().contains('filter')
                  ? 'assets/images/beans_cropped.png'
                  : 'assets/images/latteart_cropped.png',
              eligibleDrinks: dto.eligibleMenuItems
                  .where((item) => item.active)
                  .map((item) => Drink(id: item.id, name: item.name))
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  /// Get owned tickets from cache.
  ///
  /// The order of tickets in the returned list represents the user's preferred
  /// order (if they have rearranged their tickets in the UI).
  TaskEither<Failure, List<OwnedTicket>> getTicketsFromCache() {
    return _localDataProvider.get();
  }

  /// Cache owned tickets.
  ///
  /// The order of tickets in [tickets] represents the user's preferred order
  /// (if they have rearranged their tickets in the UI), so this order is
  /// preserved when caching.
  TaskEither<Failure, Unit> cacheTickets(List<OwnedTicket> tickets) {
    return _localDataProvider.set(tickets);
  }
}
