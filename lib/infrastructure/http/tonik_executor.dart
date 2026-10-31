import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/tonik_api_client.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:tonik_util/tonik_util.dart';

/// A non-2xx response or an unexpected response variant.
class TonikHttpException implements Exception {
  const new(this.statusCode, [this.message]);

  final int statusCode;
  final String? message;

  @override
  String toString() => message ?? 'Server returned $statusCode';
}

/// Throws a [TonikHttpException] for an unexpected response variant.
Never throwTonikHttp(int statusCode, [String? message]) =>
    throw TonikHttpException(statusCode, message);

/// Executes Tonik API calls and maps their results to the app's [Failure] type.
class NetworkRequestExecutor {
  const new({required this.logger, required this.api});

  final Logger logger;
  final TonikApiClient api;

  TaskEither<Failure, T> run<T, R extends Object>(
    Future<TonikResult<R, Response<Object?>>> Function(TonikApiClient api)
    request,
    T Function(R response) decode,
  ) {
    return TaskEither.tryCatch(
      () async {
        final result = await request(api);
        return switch (result) {
          TonikSuccess(:final value) => decode(value),
          TonikError(:final error, :final type, :final stackTrace) =>
            throw _TonikCallFailure(error, type, stackTrace),
        };
      },
      (error, stackTrace) {
        logger.e(error.toString());
        if (error is TonikHttpException) {
          return ServerFailure(
            error.message ?? 'An unknown error occurred (${error.statusCode})',
            error.statusCode,
          );
        }
        if (error is _TonikCallFailure) {
          if (error.type == TonikErrorType.network) {
            return const ConnectionFailure();
          }
          return UnexpectedFailure(error.error.toString());
        }
        if (error is DioException) {
          return const ConnectionFailure();
        }
        return UnexpectedFailure(error.toString());
      },
    );
  }
}

class _TonikCallFailure implements Exception {
  const new(this.error, this.type, this.stackTrace);

  final Object error;
  final TonikErrorType type;
  final StackTrace stackTrace;

  @override
  String toString() => error.toString();
}
