import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/core/network_request_executor.dart';
import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.models.swagger.dart';
import 'package:fpdart/fpdart.dart';

class OwnedTicketsRemoteDataProvider {
  const OwnedTicketsRemoteDataProvider({
    required NetworkRequestExecutor executor,
  }) : _executor = executor;

  final NetworkRequestExecutor _executor;

  /// Fetches the list of owned tickets for the current user.
  TaskEither<Failure, List<TicketResponse>> get() {
    return _executor.run((api) => api.v2.ticketsGet(includeUsed: false));
  }
}
