import 'package:cafe_analog_app/features/login/bloc/auth_cubit_handle.dart';
import 'package:cafe_analog_app/features/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/features/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class _MockAuthTokenRepository extends Mock implements AuthTokenRepository {}

class _MockCoffeecardApiV2 extends Mock implements CoffeecardApiV2 {}

class _MockAuthCubitHandle extends Mock implements AuthCubitHandle {}

/// Builds a minimal Chopper [Request] for the given path.
Request _buildRequest(String path, {Map<String, String> headers = const {}}) {
  return Request(
    'GET',
    Uri.parse('https://core.dev.analogio.dk$path'),
    Uri.parse('https://core.dev.analogio.dk'),
    headers: headers,
  );
}

/// Builds a Chopper [Response] with the given status code.
Response<dynamic> _buildResponse(int statusCode) {
  return Response(
    http.StreamedResponse(const Stream.empty(), statusCode),
    null,
  );
}

/// Builds a successful [Response<UserLoginResponse>].
Response<UserLoginResponse> _buildRefreshSuccessResponse({
  required String jwt,
  required String refreshToken,
}) {
  final body = UserLoginResponse(jwt: jwt, refreshToken: refreshToken);
  return Response(http.StreamedResponse(const Stream.empty(), 200), body);
}

/// Builds a failed [Response<UserLoginResponse>].
Response<UserLoginResponse> _buildRefreshFailureResponse(int statusCode) {
  return Response(
    http.StreamedResponse(const Stream.empty(), statusCode),
    null,
  );
}

void main() {
  late _MockAuthTokenRepository authTokenRepository;
  late _MockCoffeecardApiV2 tokenRefreshApi;
  late _MockAuthCubitHandle authCubitHandle;
  late TokenRefreshAuthenticator authenticator;

  const existingTokens = AuthTokens(jwt: 'old-jwt', refreshToken: 'old-ref');
  const newTokens = AuthTokens(jwt: 'new-jwt', refreshToken: 'new-ref');

  setUp(() {
    authTokenRepository = _MockAuthTokenRepository();
    tokenRefreshApi = _MockCoffeecardApiV2();
    authCubitHandle = _MockAuthCubitHandle();

    authenticator = TokenRefreshAuthenticator(
      authTokenRepository: authTokenRepository,
      tokenRefreshApi: tokenRefreshApi,
      authCubitHandle: authCubitHandle,
    );
  });

  group('TokenRefreshAuthenticator', () {
    group('ignores non-401 responses', () {
      for (final code in [200, 400, 403, 500]) {
        test('returns null for $code', () async {
          final result = await authenticator.authenticate(
            _buildRequest('/api/v2/tickets'),
            _buildResponse(code),
          );
          expect(result, isNull);
          verifyZeroInteractions(authTokenRepository);
          verifyZeroInteractions(tokenRefreshApi);
          verifyZeroInteractions(authCubitHandle);
        });
      }
    });

    test('ignores requests already marked with retry header', () async {
      final result = await authenticator.authenticate(
        _buildRequest('/api/v2/tickets', headers: {'X-Auth-Retry': 'true'}),
        _buildResponse(401),
      );
      expect(result, isNull);
      verifyZeroInteractions(authTokenRepository);
    });

    test('ignores auth endpoint to prevent refresh loops', () async {
      final result = await authenticator.authenticate(
        _buildRequest('/api/v2/account/auth'),
        _buildResponse(401),
      );
      expect(result, isNull);
      verifyZeroInteractions(authTokenRepository);
    });

    group('on 401 with successful token refresh', () {
      setUp(() {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(TaskEither.right(some(existingTokens)));

        when(
          () => tokenRefreshApi.accountAuthPost(
            body: TokenLoginRequest(token: existingTokens.refreshToken),
          ),
        ).thenAnswer(
          (_) async => _buildRefreshSuccessResponse(
            jwt: newTokens.jwt,
            refreshToken: newTokens.refreshToken,
          ),
        );

        when(
          () => authTokenRepository.saveTokens(newTokens),
        ).thenReturn(TaskEither.right(newTokens));
      });

      test('retries the request with the new JWT', () async {
        final original = _buildRequest('/api/v2/tickets');
        final result = await authenticator.authenticate(
          original,
          _buildResponse(401),
        );

        expect(result, isNotNull);
        expect(result!.headers['Authorization'], 'Bearer ${newTokens.jwt}');
      });

      test('adds retry header to prevent infinite loops', () async {
        final result = await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );

        expect(result!.headers['X-Auth-Retry'], 'true');
      });

      test('saves the new tokens', () async {
        await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );

        verify(() => authTokenRepository.saveTokens(newTokens)).called(1);
      });

      test('does not call logOut', () async {
        await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );

        verifyNever(() => authCubitHandle.logOut());
      });
    });

    group('on 401 with no stored tokens', () {
      setUp(() {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(TaskEither.right(none()));

        when(() => authCubitHandle.logOut()).thenAnswer((_) async {});
      });

      test('returns null', () async {
        final result = await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );
        expect(result, isNull);
      });

      test('calls logOut on the cubit handle', () async {
        await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );
        verify(() => authCubitHandle.logOut()).called(1);
      });

      test('does not call the refresh API', () async {
        await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );
        verifyZeroInteractions(tokenRefreshApi);
      });
    });

    group('on 401 with failed refresh response from server', () {
      setUp(() {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(TaskEither.right(some(existingTokens)));

        when(
          () => tokenRefreshApi.accountAuthPost(body: any(named: 'body')),
        ).thenAnswer((_) async => _buildRefreshFailureResponse(401));

        when(() => authCubitHandle.logOut()).thenAnswer((_) async {});
      });

      test('returns null', () async {
        final result = await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );
        expect(result, isNull);
      });

      test('calls logOut on the cubit handle', () async {
        await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );
        verify(() => authCubitHandle.logOut()).called(1);
      });
    });

    group('on 401 with exception during token refresh', () {
      setUp(() {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(TaskEither.right(some(existingTokens)));

        when(
          () => tokenRefreshApi.accountAuthPost(body: any(named: 'body')),
        ).thenThrow(Exception('Network error'));

        when(() => authCubitHandle.logOut()).thenAnswer((_) async {});
      });

      test('returns null', () async {
        final result = await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );
        expect(result, isNull);
      });

      test('calls logOut on the cubit handle', () async {
        await authenticator.authenticate(
          _buildRequest('/api/v2/tickets'),
          _buildResponse(401),
        );
        verify(() => authCubitHandle.logOut()).called(1);
      });
    });

    group('concurrent 401 responses', () {
      test('only calls the refresh API once', () async {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(TaskEither.right(some(existingTokens)));

        when(
          () => tokenRefreshApi.accountAuthPost(body: any(named: 'body')),
        ).thenAnswer((_) async {
          // Simulate network latency so second call arrives while first is
          // in-flight.
          await Future<void>.delayed(const Duration(milliseconds: 10));
          return _buildRefreshSuccessResponse(
            jwt: newTokens.jwt,
            refreshToken: newTokens.refreshToken,
          );
        });

        when(
          () => authTokenRepository.saveTokens(newTokens),
        ).thenReturn(TaskEither.right(newTokens));

        final request = _buildRequest('/api/v2/tickets');
        final response = _buildResponse(401);

        // Fire two authenticate calls without awaiting the first.
        final results = await Future.wait([
          Future.value(authenticator.authenticate(request, response)),
          Future.value(authenticator.authenticate(request, response)),
        ]);

        // Both requests should succeed with the new JWT.
        expect(results[0]!.headers['Authorization'], 'Bearer ${newTokens.jwt}');
        expect(results[1]!.headers['Authorization'], 'Bearer ${newTokens.jwt}');

        // Refresh endpoint called exactly once despite two concurrent 401s.
        verify(
          () => tokenRefreshApi.accountAuthPost(body: any(named: 'body')),
        ).called(1);
      });
    });
  });
}
