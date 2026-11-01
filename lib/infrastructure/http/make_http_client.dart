import 'package:analog_api/analog_api.dart';
import 'package:cafe_analog_app/core/environment.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tonik_util/tonik_util.dart';

/// Creates and configures the Tonik API client and its Dio interceptors.
TonikApiClient makeApiClient(BuildContext context) {
  final baseUrl = Uri.parse(apiBaseUrl);
  final base = baseUrl.toString();

  // This client is only used for token refresh, so it must not run the
  // refresh interceptor (which would recurse on a failed refresh).
  final refreshDio = Dio(BaseOptions(baseUrl: base));
  final refreshServer = CustomServer(
    baseUrl: base,
    serverConfig: ServerConfig.client(refreshDio),
  );
  final refreshAccountApi = AccountApi(refreshServer);

  final dio = Dio(BaseOptions(baseUrl: base));
  final tokenRefresh = TokenRefreshAuthenticator(
    dio: dio,
    authTokenRepository: context.read(),
    tokenRefreshApi: refreshAccountApi,
    authCubitHandle: context.read(),
  );

  dio.interceptors.addAll([
    NetworkRequestInterceptor(authTokenStore: context.read()),
    tokenRefresh,
  ]);

  final server = CustomServer(
    baseUrl: base,
    serverConfig: ServerConfig.client(dio),
  );
  return TonikApiClient(server: server);
}
