import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/login/data/login_repository.dart';
import 'package:cafe_analog_app/login/ui/authentication_navigator.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

/// Cubit responsible for managing authentication state.
///
/// It handles login, logout, token refresh, and emits appropriate
/// states based on the authentication status. These states are used by
/// [AuthNavigator] to navigate the user through the app.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthTokenRepository authTokenRepository,
    required LoginRepository loginRepository,
  }) : _authRepository = authTokenRepository,
       _loginRepository = loginRepository,
       super(const AuthInitial());

  final AuthTokenRepository _authRepository;
  final LoginRepository _loginRepository;

  /// Check current authentication status and emit appropriate state.
  Future<void> start() async {
    emit(const AuthLoading());
    final newState = await _authRepository
        .getTokens()
        .match(
          (couldNotGetTokens) => AuthFailure(reason: couldNotGetTokens.reason),
          (maybeTokens) => maybeTokens.match(
            AuthUnauthenticated.new, // on none
            (tokens) => AuthAuthenticated(tokens: tokens), // on some
          ),
        )
        .run();
    emit(newState);
  }

  /// Log the user out and clear stored tokens.
  Future<void> logOut() async {
    emit(const AuthLoading());
    final newState = await _authRepository
        .clearTokens()
        .match(
          (couldNotClear) => AuthFailure(reason: couldNotClear.reason),
          (_) => const AuthUnauthenticated(),
        )
        .run();
    emit(newState);
  }

  /// The user has requested a login magic link to be sent.
  Future<void> sendLoginLink({required String email}) async {
    emit(const AuthLoading());
    final newState = await _loginRepository
        .requestMagicLink(email)
        .match(
          (didNotSendLink) => AuthFailure(reason: didNotSendLink.reason),
          (_) => AuthEmailSent(email: email),
        )
        .run();
    emit(newState);
  }

  /// Authenticate the user with the token provided from the magic link.
  Future<void> authenticateWithToken({required String magicLinkToken}) async {
    emit(const AuthLoading());

    // Exchange the magic link token for auth tokens.
    final authenticateEither = await _loginRepository
        .authenticateWithMagicLinkToken(magicLinkToken)
        .run();

    // If authentication failed, emit failure.
    // Otherwise save tokens and emit authenticated.
    final newState = await authenticateEither.match(
      (didNotAuth) async => AuthFailure(reason: didNotAuth.reason),
      (tokens) async {
        final saveEither = await _authRepository.saveTokens(tokens).run();
        return saveEither.match(
          (couldNotSave) => AuthFailure(reason: couldNotSave.reason),
          (savedTokens) => AuthAuthenticated(tokens: savedTokens),
        );
      },
    );

    emit(newState);
  }

  /// Refresh the JWT token.
  Future<void> refreshToken({required AuthTokens tokens}) async {
    // FIXME(marfavi): implement token refresh logic
    throw UnimplementedError();
  }
}
