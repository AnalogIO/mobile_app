import 'dart:async';
import 'dart:developer';

import 'package:analog_api/analog_api.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:dio/dio.dart';
import 'package:tonik_util/tonik_util.dart';

/// Refreshes the JWT on a 401 response and retries the original request once.
class TokenRefreshAuthenticator extends Interceptor {
  new({
    required this._dio,
    required this._authTokenRepository,
    required this._tokenRefreshApi,
    required this._authCubitHandle,
  });

  /// Marks a request that has already been retried after a token refresh.
  static const _retryHeader = 'X-Auth-Retry';

  final Dio _dio;
  final AuthTokenRepository _authTokenRepository;
  final AccountApi _tokenRefreshApi;
  final AuthCubitHandle _authCubitHandle;
  Completer<AuthTokens?>? _refreshCompleter;

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode != 401) {
      handler.next(response);
      return;
    }

    final retried = await _retry(response.requestOptions);
    if (retried == null) {
      handler.next(response);
    } else {
      handler.resolve(retried);
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    final retried = await _retry(err.requestOptions);
    if (retried == null) {
      handler.next(err);
    } else {
      handler.resolve(retried);
    }
  }

  Future<Response<dynamic>?> _retry(RequestOptions options) async {
    if (options.headers[_retryHeader] == 'true') {
      return null;
    }
    if (options.path.endsWith('/api/v2/account/auth')) {
      return null;
    }

    log(
      'Received 401 response for request: ${options.uri}, '
      'attempting to refresh tokens...',
    );

    final refreshedTokens = await _refreshTokens();
    if (refreshedTokens == null) {
      await _authCubitHandle.logOut();
      return null;
    }

    options.headers['Authorization'] = 'Bearer ${refreshedTokens.jwt}';
    options.headers[_retryHeader] = 'true';

    try {
      return await _dio.fetch<dynamic>(options);
    } on DioException catch (retryError) {
      log('Retried request failed: ${retryError.message}');
      return null;
    }
  }

  Future<AuthTokens?> _refreshTokens() async {
    if (_refreshCompleter != null) {
      return await _refreshCompleter!.future;
    }

    final completer = Completer<AuthTokens?>();
    _refreshCompleter = completer;

    try {
      final existingTokens = (await _authTokenRepository.getTokens().run())
          .match(
            (_) => null,
            (maybeTokens) => maybeTokens.match(() => null, (tokens) => tokens),
          );

      if (existingTokens == null) {
        log('Token refresh aborted: no tokens found in storage.');
        completer.complete(null);
        return await completer.future;
      }

      final result = await _tokenRefreshApi.accountAuthenticate(
        body: TokenLoginRequest(token: existingTokens.refreshToken),
      );

      final response = switch (result) {
        TonikSuccess(value: AccountAuthenticateResponse200(:final body)) =>
          body,
        _ => null,
      };

      if (response == null) {
        log('Token refresh failed.');
        completer.complete(null);
        return await completer.future;
      }

      final newTokens = AuthTokens(
        jwt: response.jwt,
        refreshToken: response.refreshToken,
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
      return await completer.future;
    } finally {
      _refreshCompleter = null;
    }
  }
}
