import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.models.swagger.dart';
import 'package:cafe_analog_app/http/network_request_executor.dart';
import 'package:fpdart/fpdart.dart';

class UseTicketRemoteDataProvider {
  const UseTicketRemoteDataProvider({
    required NetworkRequestExecutor executor,
  }) : _executor = executor;

  final NetworkRequestExecutor _executor;

  /// Spend a ticket with the given [ticketId]
  /// on a drink with the given [drinkId].
  TaskEither<Failure, UsedTicketResponse> spend({
    required int ticketId,
    required int drinkId,
  }) {
    return _executor.run(
      (api) => api.v2.ticketsUsePost(
        body: UseTicketRequest(productId: ticketId, menuItemId: drinkId),
      ),
    );
  }
}
