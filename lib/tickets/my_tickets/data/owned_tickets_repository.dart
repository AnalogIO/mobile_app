import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_local_data_provider.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_remote_data_provider.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/ticket_order_data_provider.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class OwnedTicketsRepository {
  const OwnedTicketsRepository({
    required OwnedTicketsRemoteDataProvider ticketsRemoteDataProvider,
    required OwnedTicketsLocalDataProvider ticketsLocalDataProvider,
    required TicketOrderDataProvider ticketsOrderDataProvider,
  }) : _ticketsRemoteDataProvider = ticketsRemoteDataProvider,
       _ticketsLocalDataProvider = ticketsLocalDataProvider,
       _ticketsOrderDataProvider = ticketsOrderDataProvider;

  final OwnedTicketsRemoteDataProvider _ticketsRemoteDataProvider;
  final OwnedTicketsLocalDataProvider _ticketsLocalDataProvider;
  final TicketOrderDataProvider _ticketsOrderDataProvider;

  TaskEither<Failure, List<OwnedTicket>> fetchTicketsFromApi() {
    return _ticketsRemoteDataProvider
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

  TaskEither<Failure, List<OwnedTicket>> getTicketsFromCache() {
    return _ticketsLocalDataProvider.get();
  }

  TaskEither<Failure, Unit> cacheTickets(List<OwnedTicket> tickets) {
    return _ticketsLocalDataProvider.set(tickets);
  }

  TaskEither<Failure, List<int>> getTicketOrder() {
    return _ticketsOrderDataProvider.get();
  }

  TaskEither<Failure, Unit> cacheTicketOrder(List<int> order) {
    return _ticketsOrderDataProvider.set(order);
  }
}
