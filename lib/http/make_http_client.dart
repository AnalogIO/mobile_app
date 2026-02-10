import 'package:cafe_analog_app/http/http.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String _baseUrl = 'https://core.dev.analogio.dk';

/// Creates and configures the [ChopperClient]s used for network requests.
ChopperClient makeHttpClient(BuildContext context) {
  // Separate http client only used to refresh token requests.
  // Calls done from this client won't trigger the authenticator
  // (token refresh logic) or interceptor (injecting jwt token in auth header).
  final tokenRefreshClient = ChopperClient(
    baseUrl: Uri.parse(_baseUrl),
    converter: $JsonSerializableConverter(),
    services: [CoffeecardApiV2.create()],
  );

  return ChopperClient(
    baseUrl: Uri.parse(_baseUrl),
    converter: $JsonSerializableConverter(),
    services: [CoffeecardApiV1.create(), CoffeecardApiV2.create()],
    interceptors: [NetworkRequestInterceptor(authTokenStore: context.read())],
    authenticator: TokenRefreshAuthenticator(
      authTokenRepository: context.read(),
      tokenRefreshApi: tokenRefreshClient.getService<CoffeecardApiV2>(),
      authCubitHandle: context.read(),
    ),
  );
}
