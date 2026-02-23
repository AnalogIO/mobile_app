import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure(super.reason);
}

sealed class NetworkFailure extends Failure {
  const NetworkFailure(super.reason);
}

class ServerFailure<BodyType> extends NetworkFailure {
  const ServerFailure(super.reason, this.statusCode);

  factory ServerFailure.fromResponse(Response<BodyType> response) {
    try {
      final jsonString =
          json.decode(response.bodyString) as Map<String, dynamic>;
      final message = jsonString['message'] as String?;

      return ServerFailure(
        '${message ?? 'An unknown error occurred'} (${response.statusCode})',
        response.statusCode,
      );
    } on Exception {
      return ServerFailure(
        'An unknown error occurred (${response.statusCode})',
        response.statusCode,
      );
    }
  }

  final int statusCode;
}

class ConnectionFailure extends NetworkFailure {
  const ConnectionFailure() : super('Could not reach the server');
}
