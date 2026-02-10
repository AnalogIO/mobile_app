import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/http/http.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:fpdart/fpdart.dart';

/// Handles data operations related to user login.
class LoginRepository {
  const LoginRepository({required NetworkRequestExecutor executor})
    : _executor = executor;

  final NetworkRequestExecutor _executor;

  /// Requests a magic link to be sent to the provided email.
  TaskEither<Failure, Unit> requestMagicLink(String email) {
    final request = UserLoginRequest(
      email: email,
      loginType: LoginType.app.value,
    );
    return _executor
        .run((api) => api.v2.accountLoginPost(body: request))
        .map((_) => unit);
  }

  /// Authenticates the user with the provided magic link token.
  TaskEither<Failure, AuthTokens> authenticateWithMagicLinkToken(String token) {
    final request = TokenLoginRequest(token: token);
    return _executor
        .run((api) => api.v2.accountAuthPost(body: request))
        .map(
          (response) => AuthTokens(
            jwt: response.jwt,
            refreshToken: response.refreshToken,
          ),
        );
  }
}
