import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

/// Handles storing and retrieving JWT and refresh tokens securely.
class AuthTokenRepository {
  AuthTokenRepository({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  static const _jwtKey = 'jwt_token';
  static const _refreshTokenKey = 'refresh_token';

  /// Saves authentication tokens securely.
  ///
  /// Returns the saved tokens on success.
  TaskEither<Failure, AuthTokens> saveTokens(AuthTokens tokens) {
    return TaskEither.tryCatch(
      () async {
        await Future.wait([
          _secureStorage.write(key: _jwtKey, value: tokens.jwt),
          _secureStorage.write(
            key: _refreshTokenKey,
            value: tokens.refreshToken,
          ),
        ]);
        return tokens;
      },
      (error, _) => LocalStorageFailure('Failed to save auth tokens: $error'),
    );
  }

  /// Retrieves the authentication tokens, if they exist.
  TaskEither<Failure, Option<AuthTokens>> getTokens() {
    return TaskEither.tryCatch(
      () async {
        final jwt = await _secureStorage.read(key: _jwtKey);
        final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
        if (jwt != null && refreshToken != null) {
          return some(AuthTokens(jwt: jwt, refreshToken: refreshToken));
        }
        return none();
      },
      (error, _) =>
          LocalStorageFailure('Failed to retrieve auth tokens: $error'),
    );
  }

  /// Clears all authentication tokens (logout).
  TaskEither<Failure, Unit> clearTokens() {
    return TaskEither.tryCatch(
      () async {
        await Future.wait<void>([
          _secureStorage.delete(key: _jwtKey),
          _secureStorage.delete(key: _refreshTokenKey),
        ]);
        return unit;
      },
      (error, _) => LocalStorageFailure('Failed to clear auth tokens: $error'),
    );
  }
}
