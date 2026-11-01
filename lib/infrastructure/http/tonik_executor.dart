import 'dart:convert';

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
          TonikSuccess(:final value, :final response) => _decode<T, R>(
            decode,
            value,
            response,
          ),
          TonikError(
            :final error,
            :final type,
            :final stackTrace,
            :final response,
          ) =>
            throw _TonikCallFailure(error, type, stackTrace, response),
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
          final statusCode = error.statusCode;
          if (statusCode != null && statusCode >= 400) {
            return ServerFailure(
              _serverErrorMessage(error.response) ??
                  'An unknown error occurred ($statusCode)',
              statusCode,
            );
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

  /// Runs [decode], enriching failures thrown for a decoded error variant with
  /// the server's message and the real HTTP status code.
  T _decode<T, R extends Object>(
    T Function(R response) decode,
    R response,
    Response<Object?> httpResponse,
  ) {
    try {
      return decode(response);
    } on TonikHttpException catch (error) {
      final statusCode = httpResponse.statusCode;
      throw TonikHttpException(
        statusCode != null && statusCode >= 400 ? statusCode : error.statusCode,
        error.message ?? _serverErrorMessage(httpResponse),
      );
    }
  }

  /// Extracts the `message` field from the backend's JSON error body.
  ///
  /// The API reports errors as `{"message": "..."}` even for status codes that
  /// are not described by the OpenAPI document, and Tonik only decodes bodies
  /// for documented response variants.
  String? _serverErrorMessage(Response<Object?>? response) {
    final data = response?.data;
    if (data == null) return null;

    final String text;
    if (data is List<int>) {
      try {
        text = utf8.decode(data);
      } on FormatException {
        return null;
      }
    } else if (data is String) {
      text = data;
    } else {
      return null;
    }

    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, Object?>) {
        final message = decoded['message'] ?? decoded['Message'];
        if (message is String && message.trim().isNotEmpty) {
          return message;
        }
      }
    } on FormatException {
      return null;
    }
    return null;
  }
}

class _TonikCallFailure implements Exception {
  const new(this.error, this.type, this.stackTrace, [this.response]);

  final Object error;
  final TonikErrorType type;
  final StackTrace stackTrace;
  final Response<Object?>? response;

  int? get statusCode => response?.statusCode;

  @override
  String toString() => error.toString();
}
