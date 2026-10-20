import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/features/login/data/login_repository.dart';
import 'package:cafe_analog_app/features/login/models/authentication_tokens.dart';
import 'package:cafe_analog_app/features/login/presentation/widgets/authentication_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'authentication_state.dart';

/// Cubit responsible for managing authentication state.
///
/// It handles login, logout, token refresh, and emits appropriate
/// states based on the authentication status. These states are used by
/// [AuthNavigator] to navigate the user through the app.
class AuthCubit extends Cubit<AuthState> {
  new({
    required AuthTokenRepository authTokenRepository,
    required this._loginRepository,
    required this._clearAuthenticatedUserContext,
  }) : _authRepository = authTokenRepository,
       super(const AuthInitial());

  final AuthTokenRepository _authRepository;
  final LoginRepository _loginRepository;

  /// A callback to clear any user-specific context (e.g. cached data)
  /// on logout or login as a different user.
  final Future<void> Function() _clearAuthenticatedUserContext;

  /// Check current authentication status and emit appropriate state.
  Future<void> start() async {
    emit(const AuthLoading());
    return await _authRepository
        .getTokens()
        .match(
          (couldNotGetTokens) => AuthFailure(reason: couldNotGetTokens.reason),
          (maybeTokens) => maybeTokens.match(
            AuthUnauthenticated.new, // on none
            (tokens) => AuthAuthenticated(tokens: tokens), // on some
          ),
        )
        .map(emit)
        .run();
  }

  /// Log the user out and clear stored tokens.
  Future<void> logOut() async {
    emit(const AuthLoading());

    return await _authRepository
        .clearTokens()
        .match(
          (couldNotClearTokens) =>
              AuthFailure(reason: couldNotClearTokens.reason),
          (_) => const AuthUnauthenticated(),
        )
        .map(emit)
        .andThen(() => _clearUserContextTask)
        .run();
  }

  /// The user has requested a login magic link to be sent.
  Future<void> sendLoginLink({required String email}) async {
    emit(const AuthLoading());
    return await _loginRepository
        .requestMagicLink(email)
        .match(
          (didNotSendLink) => AuthFailure(reason: didNotSendLink.reason),
          (_) => AuthEmailSent(email: email),
        )
        .map(emit)
        .run();
  }

  /// Authenticate the user with the token provided from the magic link.
  Future<void> authenticateWithToken({required String magicLinkToken}) async {
    emit(const AuthLoading());

    return await _loginRepository
        .authenticateWithMagicLinkToken(magicLinkToken)
        // .chainFirst((_) => _clearUserContextTask)
        .flatMap(_authRepository.saveTokens)
        .match(
          (failure) => AuthFailure(reason: failure.reason),
          (savedTokens) => AuthAuthenticated(tokens: savedTokens),
        )
        .map(emit)
        .andThen(() => _clearUserContextTask)
        .run();
  }

  /// Completes the account registration started by the welcome email.
  ///
  /// Unlike the other auth flows, failures are returned to the caller instead
  /// of being emitted as [AuthFailure]: the registration screen must stay open
  /// so the user can correct their details or request a new link.
  Future<Either<Failure, Unit>> completeRegistration({
    required String registrationToken,
    required String name,
    required int programmeId,
  }) async {
    final result = await _loginRepository
        .completeRegistration(
          registrationToken: registrationToken,
          name: name,
          programmeId: programmeId,
        )
        .flatMap(_authRepository.saveTokens)
        .run();

    return switch (result) {
      Left(value: final failure) => Left(failure),
      Right(value: final tokens) => await _onRegistrationCompleted(tokens),
    };
  }

  Future<Either<Failure, Unit>> _onRegistrationCompleted(
    AuthTokens tokens,
  ) async {
    await _clearUserContextTask.run();
    emit(AuthAuthenticated(tokens: tokens));
    return const Right(unit);
  }

  /// Silently exchanges the stored refresh token for a fresh token pair.
  ///
  /// The backend resolves the account from the JWT's email claim. Changing
  /// the user's email therefore invalidates the current JWT, so after an
  /// email update the app must obtain new tokens (which carry the new email)
  /// to keep the session working.
  ///
  /// Unlike the other auth flows, this emits **no** states: [AuthNavigator]
  /// navigates on every `AuthAuthenticated`/`AuthUnauthenticated` emission,
  /// which would yank the user out of the screen they are on. The caller
  /// decides how to react based on the returned value.
  ///
  /// Returns `true` when the tokens were successfully refreshed.
  Future<bool> refreshSession() async {
    final tokensEither = await _authRepository.getTokens().run();
    final maybeTokens = tokensEither.getOrElse((_) => none());
    final refreshToken = maybeTokens.match(
      () => null,
      (tokens) => tokens.refreshToken,
    );
    if (refreshToken == null) return false;

    final refreshEither = await _loginRepository
        .authenticateWithMagicLinkToken(refreshToken)
        .flatMap(_authRepository.saveTokens)
        .run();

    return refreshEither.isRight();
  }

  /// A task that attempts to clear user context via
  /// the supplied [_clearAuthenticatedUserContext] callback.
  ///
  /// It silently catches and ignores any errors as it is a low-priority cleanup
  /// operation that should not interfere with the main auth flow.
  Task<void> get _clearUserContextTask {
    return Task<void>(() async {
      try {
        await _clearAuthenticatedUserContext();
      } finally {
        // Don't fail if the cleanup throws an error.
      }
    });
  }
}
