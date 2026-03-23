import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/use_ticket/data/use_ticket_remote_data_provider.dart';
import 'package:cafe_analog_app/tickets/use_ticket/data/used_ticket_info.dart';
import 'package:fpdart/fpdart.dart';

class UseTicketRepository {
  const UseTicketRepository({
    required UseTicketRemoteDataProvider remoteDataProvider,
  }) : _remoteDataProvider = remoteDataProvider;

  final UseTicketRemoteDataProvider _remoteDataProvider;

  /// Spend a ticket with the given [ticketId]
  /// on a drink with the given [drinkId].
  TaskEither<Failure, UsedTicketInfo> spend({
    required int ticketId,
    required int drinkId,
  }) {
    return _remoteDataProvider
        .spend(ticketId: ticketId, drinkId: drinkId)
        .map(
          (response) => UsedTicketInfo(
            // menuItemName can be null for backwards compatibility reasons
            drinkName: response.menuItemName ?? 'Some drink',
            ticketName: response.productName,
            usedAt: response.dateUsed,
          ),
        );
  }
}
