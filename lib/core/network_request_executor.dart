import 'package:chopper/chopper.dart' show Response;
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:router_test_app/core/failures.dart';

class NetworkRequestExecutor {
  const NetworkRequestExecutor({required this.logger});

  final Logger logger;

  /// Executes a network request and returns a [TaskEither].
  ///
  /// If the request fails, a [NetworkFailure] is returned in a [Left].
  /// If the request succeeds, the response body of type
  /// [BodyType] is returned in a [Right].
  TaskEither<NetworkFailure, BodyType> execute<BodyType>(
    Future<Response<BodyType>> Function() request,
  ) {
    return TaskEither<NetworkFailure, Response<BodyType>>.tryCatch(
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
