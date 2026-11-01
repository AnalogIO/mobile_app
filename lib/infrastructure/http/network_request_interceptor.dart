import 'package:cafe_analog_app/features/login/data/auth_token_store.dart';
import 'package:dio/dio.dart';

/// Adds the current JWT to outgoing requests.
class NetworkRequestInterceptor extends Interceptor {
  new({required this._authTokenStore});

  final AuthTokenStore _authTokenStore;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authTokenStore.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
