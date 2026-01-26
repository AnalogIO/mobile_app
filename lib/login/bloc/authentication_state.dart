part of 'authentication_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required this.tokens});
  final AuthTokens tokens;

  @override
  List<Object?> get props => [tokens];
}

final class AuthEmailSent extends AuthState {
  const AuthEmailSent({required this.email});
  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

final class AuthFailure extends AuthState {
  const AuthFailure({required this.reason});
  final String reason;

  @override
  List<Object?> get props => [reason];
}
