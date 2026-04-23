import 'package:cafe_analog_app/features/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// In-memory cache of the current JWT for use by the network layer.
///
/// The canonical source of truth for tokens is [FlutterSecureStorage], but
/// reads from secure storage are asynchronous. The [NetworkRequestInterceptor]
/// runs synchronously inside Chopper's request pipeline, so it cannot `await`
/// a storage read on every outgoing request.
///
/// [AuthTokenRepository] keeps this store up to date whenever tokens are
/// saved, refreshed, or cleared, ensuring the interceptor always has an
/// immediately available value to attach as the `Authorization` header.
class AuthTokenStore {
  String? token;
}
