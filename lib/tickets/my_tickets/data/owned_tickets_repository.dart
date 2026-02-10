import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_local_data_provider.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_remote_data_provider.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class OwnedTicketsRepository {
  const OwnedTicketsRepository({
    required OwnedTicketsRemoteDataProvider remoteDataProvider,
    required OwnedTicketsLocalDataProvider localDataProvider,
  }) : _remoteDataProvider = remoteDataProvider,
       _localDataProvider = localDataProvider;

  final OwnedTicketsRemoteDataProvider _remoteDataProvider;
  final OwnedTicketsLocalDataProvider _localDataProvider;

  /// Fetch owned tickets from API in any order.
  TaskEither<Failure, List<OwnedTicket>> fetchTicketsFromApi() {
    return _remoteDataProvider
        .get()
        // Each dto represent one "clip" left on a ticket, so we need to
        // create groups of ticket reponse objects grouped by product id,
        // creating a list of key-value pairs (product id, list of dtos with id)
        .map((dtos) => dtos.groupListsBy((dto) => dto.productId).entries)
        // map each key-value pair to an OwnedTicket
        .map(
          (entries) => entries.map((entry) {
            final tickets = entry.value;
            return OwnedTicket(
              productId: entry.key,
              ticketName: tickets.first.productName,
              ticketsLeft: tickets.length,
              backgroundImagePath:
                  // choose background based on some rudimentary logic
                  tickets.first.productName.toLowerCase().contains('filter')
                  ? 'assets/images/beans_cropped.png'
                  : 'assets/images/latteart_cropped.png',
            );
          }),
        )
        // Convert Iterable to List
        .map(List.of);
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
