import 'dart:async';

import 'package:chopper/chopper.dart';

class AuthTokenStore {
  String? token;
}

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
