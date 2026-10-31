import 'dart:async';

import 'package:analog_api/analog_api.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tonik_util/tonik_util.dart';

import 'fake_http_client_adapter.dart';

class _MockAuthTokenRepository extends Mock implements AuthTokenRepository;

class _MockAuthCubitHandle extends Mock implements AuthCubitHandle;

const _baseUrl = 'https://example.test';
const _existingTokens = AuthTokens(jwt: 'OLD-JWT', refreshToken: 'OLD-REF');
const _newTokens = AuthTokens(jwt: 'NEW-JWT', refreshToken: 'NEW-REF');

void main() {
  late _MockAuthTokenRepository authTokenRepository;
  late _MockAuthCubitHandle authCubitHandle;
  late Dio dio;
  late FakeHttpClientAdapter adapter;
  late FakeHttpClientAdapter refreshAdapter;

  setUp(() {
    authTokenRepository = _MockAuthTokenRepository();
    authCubitHandle = _MockAuthCubitHandle();
    when(() => authCubitHandle.logOut()).thenAnswer((_) async {});
    when(() => authTokenRepository.getTokens())
        .thenReturn(TaskEither.right(some(_existingTokens)));
    when(() => authTokenRepository.saveTokens(_newTokens))
        .thenReturn(TaskEither.right(_newTokens));

    final refreshDio = Dio(BaseOptions(baseUrl: _baseUrl));
    refreshAdapter = FakeHttpClientAdapter(
      (options) async => jsonResponse({
        'jwt': _newTokens.jwt,
        'refreshToken': _newTokens.refreshToken,
      }, 200),
    );
    refreshDio.httpClientAdapter = refreshAdapter;
    final refreshServer = CustomServer(
      baseUrl: _baseUrl,
      serverConfig: ServerConfig.client(refreshDio),
    );

    dio = Dio(BaseOptions(baseUrl: _baseUrl));
    adapter = FakeHttpClientAdapter(
      (options) async => jsonResponse({'message': 'expired'}, 401),
    );
    dio.httpClientAdapter = adapter;
    dio.interceptors.add(
      TokenRefreshAuthenticator(
        dio: dio,
        authTokenRepository: authTokenRepository,
        tokenRefreshApi: AccountApi(refreshServer),
        authCubitHandle: authCubitHandle,
      ),
    );
  });

  /// A main-client handler that answers 401 once and 200 after the retry.
  FakeHttpHandler successfulRetryHandler() {
    return (options) async {
      if (options.headers['X-Auth-Retry'] == 'true') {
        return jsonResponse({'ok': true}, 200);
      }
      return jsonResponse({'message': 'expired'}, 401);
    };
  }

  group('TokenRefreshAuthenticator', () {
    test('passes non-401 responses through without refreshing', () async {
      adapter.handler = (options) async => jsonResponse({'ok': true}, 200);

      final response = await dio.get<dynamic>('/api/v2/account');

      expect(response.statusCode, 200);
      expect(refreshAdapter.requests, isEmpty);
      verifyNever(() => authTokenRepository.getTokens());
      verifyNever(() => authCubitHandle.logOut());
    });

    test('passes non-401 errors through without refreshing', () async {
      adapter.handler = (options) async =>
          jsonResponse({'message': 'boom'}, 500);

      await expectLater(
        dio.get<dynamic>('/api/v2/account'),
        throwsA(isA<DioException>()),
      );
      expect(refreshAdapter.requests, isEmpty);
      verifyNever(() => authTokenRepository.getTokens());
    });

    test('refreshes and retries a 401 response', () async {
      adapter.handler = successfulRetryHandler();

      final response = await dio.get<dynamic>(
        '/api/v2/account',
        options: Options(validateStatus: (_) => true),
      );

      expect(response.statusCode, 200);
      expect(adapter.requests, hasLength(2));
      expect(adapter.requests.last.headers['Authorization'], 'Bearer NEW-JWT');
      expect(adapter.requests.last.headers['X-Auth-Retry'], 'true');
      expect(refreshAdapter.requests, hasLength(1));
      verify(() => authTokenRepository.saveTokens(_newTokens)).called(1);
      verifyNever(() => authCubitHandle.logOut());
    });

    test('refreshes and retries a 401 error', () async {
      adapter.handler = successfulRetryHandler();

      final response = await dio.get<dynamic>('/api/v2/account');

      expect(response.statusCode, 200);
      expect(adapter.requests, hasLength(2));
      expect(adapter.requests.last.headers['Authorization'], 'Bearer NEW-JWT');
      expect(adapter.requests.last.headers['X-Auth-Retry'], 'true');
      expect(refreshAdapter.requests, hasLength(1));
      verify(() => authTokenRepository.saveTokens(_newTokens)).called(1);
      verifyNever(() => authCubitHandle.logOut());
    });

    test(
      'does not retry a request that already has the retry header',
      () async {
        adapter.handler = (options) async =>
            jsonResponse({'message': 'expired'}, 401);

        final response = await dio.get<dynamic>(
          '/api/v2/account',
          options: Options(validateStatus: (_) => true),
        );

        expect(response.statusCode, 401);
        expect(adapter.requests, hasLength(2));
        expect(refreshAdapter.requests, hasLength(1));
        verify(() => authTokenRepository.saveTokens(_newTokens)).called(1);
        verifyNever(() => authCubitHandle.logOut());
      },
    );

    test('does not refresh the auth endpoint', () async {
      adapter.handler = (options) async =>
          jsonResponse({'message': 'invalid'}, 401);

      final response = await dio.post<dynamic>(
        '/api/v2/account/auth',
        data: {'token': 'bad'},
        options: Options(validateStatus: (_) => true),
      );

      expect(response.statusCode, 401);
      expect(refreshAdapter.requests, isEmpty);
      verifyNever(() => authTokenRepository.getTokens());
      verifyNever(() => authCubitHandle.logOut());
    });

    test('logs out when no tokens are stored', () async {
      when(() => authTokenRepository.getTokens())
          .thenReturn(TaskEither.right(none()));
      adapter.handler = (options) async =>
          jsonResponse({'message': 'expired'}, 401);

      final response = await dio.get<dynamic>(
        '/api/v2/account',
        options: Options(validateStatus: (_) => true),
      );

      expect(response.statusCode, 401);
      expect(refreshAdapter.requests, isEmpty);
      verify(() => authCubitHandle.logOut()).called(1);
      verifyNever(() => authTokenRepository.saveTokens(_newTokens));
    });

    test('logs out when the refresh request is rejected', () async {
      refreshAdapter.handler = (options) async =>
          jsonResponse({'message': 'invalid'}, 401);
      adapter.handler = (options) async =>
          jsonResponse({'message': 'expired'}, 401);

      final response = await dio.get<dynamic>(
        '/api/v2/account',
        options: Options(validateStatus: (_) => true),
      );

      expect(response.statusCode, 401);
      expect(refreshAdapter.requests, hasLength(1));
      verify(() => authCubitHandle.logOut()).called(1);
      verifyNever(() => authTokenRepository.saveTokens(_newTokens));
    });

    test('logs out when the refresh request throws', () async {
      refreshAdapter.handler = (options) async => throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
      );
      adapter.handler = (options) async =>
          jsonResponse({'message': 'expired'}, 401);

      final response = await dio.get<dynamic>(
        '/api/v2/account',
        options: Options(validateStatus: (_) => true),
      );

      expect(response.statusCode, 401);
      verify(() => authCubitHandle.logOut()).called(1);
      verifyNever(() => authTokenRepository.saveTokens(_newTokens));
    });

    test('logs out when saving refreshed tokens fails', () async {
      when(() => authTokenRepository.saveTokens(_newTokens))
          .thenReturn(TaskEither.left(const LocalStorageFailure('disk full')));
      adapter.handler = successfulRetryHandler();

      final response = await dio.get<dynamic>(
        '/api/v2/account',
        options: Options(validateStatus: (_) => true),
      );

      expect(response.statusCode, 401);
      verify(() => authCubitHandle.logOut()).called(1);
    });

    test('shares one refresh between concurrent 401s', () async {
      final refreshGate = Completer<void>();
      refreshAdapter.handler = (options) async {
        await refreshGate.future;
        return jsonResponse({
          'jwt': _newTokens.jwt,
          'refreshToken': _newTokens.refreshToken,
        }, 200);
      };

      final bothRequestsSeen = Completer<void>();
      adapter.handler = (options) async {
        if (options.headers['X-Auth-Retry'] == 'true') {
          return jsonResponse({'ok': true}, 200);
        }
        if (adapter.requests.length >= 2 && !bothRequestsSeen.isCompleted) {
          bothRequestsSeen.complete();
        }
        return jsonResponse({'message': 'expired'}, 401);
      };

      final first = dio.get<dynamic>(
        '/api/v2/account',
        options: Options(validateStatus: (_) => true),
      );
      final second = dio.get<dynamic>(
        '/api/v2/account',
        options: Options(validateStatus: (_) => true),
      );

      await bothRequestsSeen.future;
      // Let the second 401 reach the interceptor and join the in-flight
      // refresh before the refresh is allowed to complete.
      await pumpEventQueue();
      refreshGate.complete();

      final responses = await Future.wait([first, second]);

      expect(responses.map((response) => response.statusCode), [200, 200]);
      expect(refreshAdapter.requests, hasLength(1));
      verify(() => authTokenRepository.saveTokens(_newTokens)).called(1);
    });

    test('surfaces a network failure from the retried request', () async {
      adapter.handler = (options) async {
        if (options.headers['X-Auth-Retry'] == 'true') {
          throw DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
          );
        }
        return jsonResponse({'message': 'expired'}, 401);
      };

      await expectLater(
        dio.get<dynamic>(
          '/api/v2/account',
          options: Options(validateStatus: (_) => true),
        ),
        throwsA(isA<DioException>()),
      );
      expect(refreshAdapter.requests, hasLength(1));
      verify(() => authTokenRepository.saveTokens(_newTokens)).called(1);
    });
  });
}
