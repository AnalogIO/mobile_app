part of 'authentication_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// The cubit was initialized but no action has been taken yet.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Some action is happening (such as requesting a magic link, clearing saved
/// tokens from local storage, etc).
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// The user is successfully authenticated.
final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required this.tokens});
  final AuthTokens tokens;

  @override
  List<Object?> get props => [tokens];
}

/// A login magic link has been sent to the user's email.
final class AuthEmailSent extends AuthState {
  const AuthEmailSent({required this.email});
  final String email;

  @override
  List<Object?> get props => [email];
}

/// The user is not authenticated.
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Some failure occurred during an authentication-related operation (such as
/// requesting a magic link, clearing saved tokens from local storage, etc).
final class AuthFailure extends AuthState {
  const AuthFailure({required this.reason});
  final String reason;

  @override
  List<Object?> get props => [reason];
}
