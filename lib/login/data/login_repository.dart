import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/core/network_request_executor.dart';
import 'package:cafe_analog_app/generated/api/client_index.dart';
import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.enums.swagger.dart';
import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.models.swagger.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:fpdart/fpdart.dart';

/// Handles data operations related to user login.
class LoginRepository {
  const LoginRepository({
    required CoffeecardApiV2 apiV2,
    required NetworkRequestExecutor executor,
  }) : _apiV2 = apiV2,
       _executor = executor;

  final CoffeecardApiV2 _apiV2;
  final NetworkRequestExecutor _executor;

  /// Requests a magic link to be sent to the provided email.
  TaskEither<Failure, Unit> requestMagicLink(String email) {
    final request = UserLoginRequest(
      email: email,
      loginType: LoginType.app.value,
    );
    return _executor
        .execute(() => _apiV2.accountLoginPost(body: request))
        .map((_) => unit);
  }

  /// Authorizes the user with the provided magic link token.
  TaskEither<Failure, AuthTokens> authorizeWithToken(String token) {
    final request = TokenLoginRequest(token: token);
    return _executor
        .execute(() => _apiV2.accountAuthPost(body: request))
        .map(
          (response) => AuthTokens(
            jwt: response.jwt,
            refreshToken: response.refreshToken,
          ),
        );
  }
}
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/core/network_request_executor.dart';
import 'package:cafe_analog_app/generated/api/client_index.dart';
import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.enums.swagger.dart';
import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.models.swagger.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:fpdart/fpdart.dart';

/// Handles data operations related to user login.
class LoginRepository {
  const LoginRepository({
    required CoffeecardApiV2 apiV2,
    required NetworkRequestExecutor executor,
  }) : _apiV2 = apiV2,
       _executor = executor;

  final CoffeecardApiV2 _apiV2;
  final NetworkRequestExecutor _executor;

  /// Requests a magic link to be sent to the provided email.
  TaskEither<Failure, Unit> requestMagicLink(String email) {
    final request = UserLoginRequest(
      email: email,
      loginType: LoginType.app.value,
    );
    return _executor
        .execute(() => _apiV2.accountLoginPost(body: request))
        .map((_) => unit);
  }

  /// Authenticates the user with the provided magic link token.
  TaskEither<Failure, AuthTokens> authenticateWithMagicLinkToken(String token) {
    final request = TokenLoginRequest(token: token);
    return _executor
        .execute(() => _apiV2.accountAuthPost(body: request))
        .map(
          (response) => AuthTokens(
            jwt: response.jwt,
            refreshToken: response.refreshToken,
          ),
        );
  }
}
