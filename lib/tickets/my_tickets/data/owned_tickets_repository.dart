import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/catalog/data/ticket_catalog_remote_data_provider.dart';
import 'package:cafe_analog_app/tickets/catalog/drink.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_local_data_provider.dart';
import 'package:fpdart/fpdart.dart';

class OwnedTicketsRepository {
  const OwnedTicketsRepository({
    required OwnedTicketsLocalDataProvider localDataProvider,
    required TicketCatalogRemoteDataProvider catalogRemoteDataProvider,
  }) : _localDataProvider = localDataProvider,
       _catalogRemoteDataProvider = catalogRemoteDataProvider;

  final OwnedTicketsLocalDataProvider _localDataProvider;
  final TicketCatalogRemoteDataProvider _catalogRemoteDataProvider;

  /// Fetch owned tickets from API in any order, with their eligible drinks
  /// assigned.
  TaskEither<Failure, List<OwnedTicket>> fetchTicketsFromApi() {
    return _catalogRemoteDataProvider.getProducts().map(
      (dtos) => dtos
          .map(
            (dto) => OwnedTicket(
              productId: dto.id,
              ticketName: dto.name,
              ticketsLeft: dto.numberOfTickets,
              backgroundImagePath:
                  // choose background based on some rudimentary logic
                  dto.name.toLowerCase().contains('filter')
                  ? 'assets/images/beans_cropped.png'
                  : 'assets/images/latteart_cropped.png',
              eligibleDrinks:
                  dto.eligibleMenuItems
                      ?.where((item) => item.active)
                      .map((item) => Drink(id: item.id, name: item.name))
                      .toList() ??
                  // use an empty list is eligibleMenuItems is null
                  //  - it can be null for backwards compatibility reasons
                  [],
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
