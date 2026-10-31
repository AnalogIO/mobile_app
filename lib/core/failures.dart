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

class ServerFailure extends NetworkFailure {
  const new(super.reason, this.statusCode);

  final int statusCode;
}

class ConnectionFailure extends NetworkFailure {
  const new() : super('Could not reach the server');
}
