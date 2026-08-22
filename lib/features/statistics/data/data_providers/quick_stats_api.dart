import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

class QuickStatsApi {
  const QuickStatsApi({required this._executor});

  final NetworkRequestExecutor _executor;

  TaskEither<Failure, List<QuickStatResponse>> fetchQuickStats() {
    return _executor.run((api) => api.v2.statisticsQuickGet());
  }
}
