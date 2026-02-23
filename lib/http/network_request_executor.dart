import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/http/http.dart';
import 'package:chopper/chopper.dart' show Response;
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

class NetworkRequestExecutor {
  const NetworkRequestExecutor({
    required this.logger,
    required this.apiV1,
    required this.apiV2,
  });

  final Logger logger;
  final CoffeecardApiV1 apiV1;
  final CoffeecardApiV2 apiV2;

  /// Executes a network request and returns a [TaskEither].
  ///
  /// If the request fails, a [Failure] is returned in a [Left].
  /// If the request succeeds, the response body of type
  /// [BodyType] is returned in a [Right].
  ///
  /// ```dart
  /// executor.run((api) => api.v2.accountAuthPost(...));
  /// ```
  TaskEither<Failure, BodyType> run<BodyType>(
    Future<Response<BodyType>> Function(ApiClients api) request,
  ) {
    final clients = ApiClients(v1: apiV1, v2: apiV2);
    return _execute<BodyType>(() => request(clients));
  }

  TaskEither<Failure, BodyType> _execute<BodyType>(
    Future<Response<BodyType>> Function() request,
  ) {
    return TaskEither<Failure, Response<BodyType>>.tryCatch(
      request,
      (error, stackTrace) {
        logger.e(error.toString());
        return const ConnectionFailure();
      },
    ).flatMap(
      (response) {
        if (response.isSuccessful) {
          return TaskEither.right(response.body as BodyType);
        } else {
          logger.e(response.toString());
          return TaskEither.left(ServerFailure.fromResponse(response));
        }
      },
    );
  }
}

/// Small helper that groups generated API clients.
class ApiClients {
  const ApiClients({required this.v1, required this.v2});

  final CoffeecardApiV1 v1;
  final CoffeecardApiV2 v2;
}
