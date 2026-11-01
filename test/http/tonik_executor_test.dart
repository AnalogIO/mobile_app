import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:tonik_util/tonik_util.dart';

import 'fake_http_client_adapter.dart';

void main() {
  late FakeHttpClientAdapter adapter;
  late NetworkRequestExecutor executor;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    adapter = FakeHttpClientAdapter(
      (options) async => jsonResponse({'message': 'unexpected'}, 500),
    );
    dio.httpClientAdapter = adapter;

    final server = CustomServer(
      baseUrl: 'https://example.test',
      serverConfig: ServerConfig.client(dio),
    );
    executor = NetworkRequestExecutor(
      logger: Logger(level: Level.off),
      api: TonikApiClient(server: server),
    );
  });

  test('uses the server message for an undocumented error status', () async {
    adapter.handler = (options) async => jsonResponse({
      'message': 'The email taken@example.com is already in use!',
    }, 400);

    final result = await executor
        .run(
          (api) => api.account.accountUpdate(
            body: const UpdateUserRequest(email: 'taken@example.com'),
          ),
          (response) => switch (response) {
            AccountUpdateResponse200(:final body) => body.email,
            AccountUpdateResponse401() => throwTonikHttp(401),
          },
        )
        .run();

    final failure = result.match(
      (failure) => failure,
      (_) => fail('Expected the update to fail'),
    );
    expect(failure, isA<ServerFailure>());
    expect(failure.reason, 'The email taken@example.com is already in use!');
    expect((failure as ServerFailure).statusCode, 400);
  });

  test('uses the message and status of a default error variant', () async {
    adapter.handler = (options) async =>
        jsonResponse({'message': 'The token is invalid!'}, 401);

    final result = await executor
        .run(
          (api) => api.account.accountAuthenticate(
            body: const TokenLoginRequest(token: 'expired'),
          ),
          (response) => switch (response) {
            AccountAuthenticateResponse200(:final body) => body.jwt,
            AccountAuthenticateResponse404() => throwTonikHttp(404),
            AccountAuthenticateResponseDefault() => throwTonikHttp(401),
          },
        )
        .run();

    final failure = result.match(
      (failure) => failure,
      (_) => fail('Expected authentication to fail'),
    );
    expect(failure, isA<ServerFailure>());
    expect(failure.reason, 'The token is invalid!');
    expect((failure as ServerFailure).statusCode, 401);
  });

  test(
    'reports the real status for a default variant with a guessed status',
    () async {
      adapter.handler = (options) async =>
          jsonResponse({'message': 'Too many requests'}, 429);

      final result = await executor
          .run(
            (api) => api.account.accountLogin(
              body: const UserLoginRequest(
                email: 'user@example.com',
                loginType: LoginType.app,
              ),
            ),
            (response) => switch (response) {
              AccountLoginResponse204() => 'sent',
              AccountLoginResponseDefault() => throwTonikHttp(400),
            },
          )
          .run();

      final failure = result.match(
        (failure) => failure,
        (_) => fail('Expected the login request to fail'),
      );
      expect(failure, isA<ServerFailure>());
      expect(failure.reason, 'Too many requests');
      expect((failure as ServerFailure).statusCode, 429);
    },
  );

  test('keeps the message of a typed error variant', () async {
    adapter.handler = (options) async =>
        jsonResponse({'message': 'The token is invalid!'}, 401);

    final result = await executor
        .run(
          (api) => api.account.accountCompleteRegistration(
            body: const CompleteRegistrationRequest(
              token: 'token',
              name: 'Name',
              programmeId: 1,
            ),
          ),
          (response) => switch (response) {
            AccountCompleteRegistrationResponse200(:final body) => body.jwt,
            AccountCompleteRegistrationResponse400(:final body) =>
              throwTonikHttp(400, body.message),
            AccountCompleteRegistrationResponse401(:final body) =>
              throwTonikHttp(401, body.message),
          },
        )
        .run();

    final failure = result.match(
      (failure) => failure,
      (_) => fail('Expected registration to fail'),
    );
    expect(failure, isA<ServerFailure>());
    expect(failure.reason, 'The token is invalid!');
    expect((failure as ServerFailure).statusCode, 401);
  });

  test('uses the server message for an unexpected server error', () async {
    adapter.handler = (options) async =>
        jsonResponse({'message': 'An unhandled error occurred.'}, 500);

    final result = await executor
        .run(
          (api) => api.account.accountGet(),
          (response) => switch (response) {
            AccountGetResponse200(:final body) => body.email,
            AccountGetResponse401() => throwTonikHttp(401),
          },
        )
        .run();

    final failure = result.match(
      (failure) => failure,
      (_) => fail('Expected the request to fail'),
    );
    expect(failure, isA<ServerFailure>());
    expect(failure.reason, 'An unhandled error occurred.');
    expect((failure as ServerFailure).statusCode, 500);
  });

  test('maps network failures to ConnectionFailure', () async {
    adapter.handler = (options) async => throw DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
    );

    final result = await executor
        .run(
          (api) => api.account.accountGet(),
          (response) => switch (response) {
            AccountGetResponse200(:final body) => body.email,
            AccountGetResponse401() => throwTonikHttp(401),
          },
        )
        .run();

    final failure = result.match(
      (failure) => failure,
      (_) => fail('Expected the request to fail'),
    );
    expect(failure, isA<ConnectionFailure>());
  });
}
