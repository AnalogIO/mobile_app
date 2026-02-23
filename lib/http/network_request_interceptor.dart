import 'dart:async';

import 'package:cafe_analog_app/login/data/auth_token_store.dart';
import 'package:chopper/chopper.dart';

/// An interceptor that adds the Authorization header with the JWT token
/// to outgoing HTTP requests if a token is available in the [AuthTokenStore].
class NetworkRequestInterceptor implements Interceptor {
  NetworkRequestInterceptor({
    required AuthTokenStore authTokenStore,
  }) : _authTokenStore = authTokenStore;

  final AuthTokenStore _authTokenStore;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    return chain.proceed(
      switch (_authTokenStore.token) {
        null => chain.request,
        final token => applyHeader(
          chain.request,
          'Authorization',
          'Bearer $token',
        ),
      },
    );
  }
}
