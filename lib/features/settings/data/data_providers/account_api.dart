import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

/// Thin wrapper around the generated account endpoints.
class AccountApi {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  /// Fetches the current user's account data.
  TaskEither<Failure, UserResponse> getUser() {
    return _executor.run((api) => api.v2.accountGet());
  }

  /// Updates the current user's account using the given [request].
  ///
  /// Returns the updated account data.
  TaskEither<Failure, UserResponse> updateUser(UpdateUserRequest request) {
    return _executor.run((api) => api.v2.accountPut(body: request));
  }

  /// Requests deletion of the current user's account.
  ///
  /// The backend responds with `202` and sends a verification email; the
  /// account is only actually deleted when the link in that email is opened.
  TaskEither<Failure, Unit> requestAccountDeletion() {
    return _executor.run((api) => api.v2.accountDelete()).map((_) => unit);
  }
}
