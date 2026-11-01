import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

/// Thin wrapper around the generated programmes endpoint.
class ProgrammesApi {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  /// Fetches the list of available study programmes.
  TaskEither<Failure, List<ProgrammeResponse>> fetchProgrammes() {
    return _executor.run(
      (api) => api.programmes.programmesGet(),
      (programmes) => programmes,
    );
  }
}
