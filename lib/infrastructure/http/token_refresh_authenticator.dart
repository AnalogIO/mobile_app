import 'dart:async';
import 'dart:developer';

import 'package:cafe_analog_app/features/login/bloc/auth_cubit_handle.dart';
import 'package:cafe_analog_app/features/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/features/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:chopper/chopper.dart';

class TokenRefreshAuthenticator extends Authenticator {
  TokenRefreshAuthenticator({
    required this._authTokenRepository,
    required this._tokenRefreshApi,
    required this._authCubitHandle,
  });

  /// This header is added to requests that have already been retried after a
  /// token refresh. Prevents infinite retry loops in case the new token is also
  /// invalid for some reason.
  static const _retryHeader = 'X-Auth-Retry';

  final AuthTokenRepository _authTokenRepository;
  final CoffeecardApiV2 _tokenRefreshApi;
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
        log('Token refresh aborted: no tokens found in storage.');
        completer.complete(null);
        return await completer.future;
      }

      final refreshResponse = await _tokenRefreshApi.accountAuthPost(
        body: TokenLoginRequest(token: existingTokens.refreshToken),
      );
      final responseBody = refreshResponse.body;

      if (!refreshResponse.isSuccessful || responseBody == null) {
        log(
          'Token refresh failed: server responded with '
          '${refreshResponse.statusCode}.',
        );
        completer.complete(null);
        return await completer.future;
      }

      final newTokens = AuthTokens(
        jwt: responseBody.jwt,
        refreshToken: responseBody.refreshToken,
      );

      final savedTokens = await _authTokenRepository
          .saveTokens(newTokens)
          .match((_) => null, (tokens) => tokens)
          .run();

      if (savedTokens != null) {
        log('Token refresh succeeded.');
      } else {
        log('Token refresh succeeded but saving new tokens failed.');
      }
      completer.complete(savedTokens);
      return await completer.future;
    } on Exception catch (e) {
      log('Token refresh failed with exception: $e.');
      completer.complete(null);
      return completer.future;
    } finally {
      _refreshCompleter = null;
    }
  }
}
