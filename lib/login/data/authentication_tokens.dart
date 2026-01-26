import 'package:equatable/equatable.dart';

/// Represents authentication tokens received after a successful authentication.
class AuthTokens extends Equatable {
  const AuthTokens({required this.jwt, required this.refreshToken});

  final String jwt;
  final String refreshToken;

  @override
  List<Object> get props => [jwt, refreshToken];
}
