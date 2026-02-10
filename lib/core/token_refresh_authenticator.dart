import 'dart:async';
import 'dart:developer';

import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.swagger.dart';
import 'package:cafe_analog_app/login/bloc/auth_cubit_handle.dart';
import 'package:cafe_analog_app/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:chopper/chopper.dart';

class TokenRefreshAuthenticator extends Authenticator {
  TokenRefreshAuthenticator({
    required AuthTokenRepository authTokenRepository,
    required CoffeecardApiV2 authApi,
    required AuthCubitHandle authCubitHandle,
  }) : _authTokenRepository = authTokenRepository,
       _authApi = authApi,
       _authCubitHandle = authCubitHandle;

  static const _retryHeader = 'X-Auth-Retry';

  final AuthTokenRepository _authTokenRepository;
  final CoffeecardApiV2 _authApi;
  final AuthCubitHandle _authCubitHandle;
  Completer<AuthTokens?>? _refreshCompleter;

  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response<dynamic> response, [
    Request? _,
  ]) async {
    if (response.statusCode != 401) return null;
    if (request.headers[_retryHeader] == 'true') return null;
    if (request.url.path.endsWith('/api/v2/account/auth')) return null;

    log(
      'Received 401 response for request: ${request.url}, '
      'attempting to refresh tokens...\n'
      '-- Headers: ${request.headers}',
    );

    final refreshedTokens = await _refreshTokens();
    if (refreshedTokens == null) {
      await _authCubitHandle.logOut();
      return null;
    }

    final updatedRequest = applyHeader(
      request,
      'Authorization',
      'Bearer ${refreshedTokens.jwt}',
    );

    return updatedRequest.copyWith(
      headers: {...updatedRequest.headers, _retryHeader: 'true'},
    );
  }

  Future<AuthTokens?> _refreshTokens() async {
    if (_refreshCompleter != null) return _refreshCompleter!.future;

    final completer = Completer<AuthTokens?>();
    _refreshCompleter = completer;

    try {
      final tokensEither = await _authTokenRepository.getTokens().run();
      final existingTokens = tokensEither.match(
        (_) => null,
        (maybeTokens) => maybeTokens.match(
          () => null,
          (tokens) => tokens,
        ),
      );

      if (existingTokens == null) {
        completer.complete(null);
        return completer.future;
      }

      final refreshResponse = await _authApi.accountAuthPost(
        body: TokenLoginRequest(token: existingTokens.refreshToken),
      );
      final responseBody = refreshResponse.body;

      if (!refreshResponse.isSuccessful || responseBody == null) {
        completer.complete(null);
        return completer.future;
      }

      final newTokens = AuthTokens(
        jwt: responseBody.jwt,
        refreshToken: responseBody.refreshToken,
      );

      final savedTokens = await _authTokenRepository
          .saveTokens(newTokens)
          .match((_) => null, (tokens) => tokens)
          .run();

      completer.complete(savedTokens);
      return completer.future;
    } on Exception {
      completer.complete(null);
      return completer.future;
    } finally {
      _refreshCompleter = null;
    }
  }
}
