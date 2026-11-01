import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/login/models/authentication_tokens.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

/// Handles data operations related to user login.
class LoginRepository {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  /// Requests a magic link to be sent to the provided email.
  TaskEither<Failure, Unit> requestMagicLink(String email) {
    return _executor.run(
      (api) => api.account.accountLogin(
        body: UserLoginRequest(email: email, loginType: LoginType.app),
      ),
      (response) => switch (response) {
        AccountLoginResponse204() => unit,
        AccountLoginResponseDefault() => throwTonikHttp(400),
      },
    );
  }

  /// Authenticates the user with the provided magic link token.
  TaskEither<Failure, AuthTokens> authenticateWithMagicLinkToken(String token) {
    return _executor.run(
      (api) => api.account.accountAuthenticate(
        body: TokenLoginRequest(token: token),
      ),
      (response) => switch (response) {
        AccountAuthenticateResponse200(:final body) => AuthTokens(
          jwt: body.jwt,
          refreshToken: body.refreshToken,
        ),
        AccountAuthenticateResponse404() => throwTonikHttp(404),
        AccountAuthenticateResponseDefault() => throwTonikHttp(401),
      },
    );
  }

  /// Completes the registration started by the welcome email.
  ///
  /// The email is not sent here: it is read by the backend from the
  /// single-use [registrationToken].
  TaskEither<Failure, AuthTokens> completeRegistration({
    required String registrationToken,
    required String name,
    required int programmeId,
  }) {
    return _executor.run(
      (api) => api.account.accountCompleteRegistration(
        body: CompleteRegistrationRequest(
          token: registrationToken,
          name: name,
          programmeId: programmeId,
        ),
      ),
      (response) => switch (response) {
        AccountCompleteRegistrationResponse200(:final body) => AuthTokens(
          jwt: body.jwt,
          refreshToken: body.refreshToken,
        ),
        AccountCompleteRegistrationResponse400(:final body) => throwTonikHttp(
          400,
          body.message,
        ),
        AccountCompleteRegistrationResponse401(:final body) => throwTonikHttp(
          401,
          body.message,
        ),
      },
    );
  }
}
