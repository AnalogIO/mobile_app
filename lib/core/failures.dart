import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const new(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

class UnexpectedFailure extends Failure {
  const new(super.reason);
}

class LocalStorageFailure extends Failure {
  const new(super.reason);
}

sealed class NetworkFailure extends Failure {
  const new(super.reason);
}

class ServerFailure<BodyType> extends NetworkFailure {
  const new(super.reason, this.statusCode);

  factory fromResponse(Response<BodyType> response) {
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
  const new() : super('Could not reach the server');
}
