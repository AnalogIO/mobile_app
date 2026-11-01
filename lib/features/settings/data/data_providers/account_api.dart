import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

/// Thin wrapper around the generated account endpoints.
class AccountApi {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  TaskEither<Failure, UserResponse> getUser() {
    return _executor.run(
      (api) => api.account.accountGet(),
      (response) => switch (response) {
        AccountGetResponse200(:final body) => body,
        AccountGetResponse401() => throwTonikHttp(401),
      },
    );
  }

  TaskEither<Failure, UserResponse> updateUser(UpdateUserRequest request) {
    return _executor.run(
      (api) => api.account.accountUpdate(body: request),
      (response) => switch (response) {
        AccountUpdateResponse200(:final body) => body,
        AccountUpdateResponse401() => throwTonikHttp(401),
      },
    );
  }

  TaskEither<Failure, Unit> requestAccountDeletion() {
    return _executor.run(
      (api) => api.account.accountDelete(),
      (response) => switch (response) {
        AccountDeleteResponse202() => unit,
        AccountDeleteResponse401() => throwTonikHttp(401),
        AccountDeleteResponse404() => throwTonikHttp(404),
        AccountDeleteResponse429(:final body) => throwTonikHttp(
          429,
          body.message,
        ),
      },
    );
  }
}
