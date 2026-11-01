import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

class QuickStatsApi {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  TaskEither<Failure, List<QuickStatResponse>> fetchQuickStats() {
    return _executor.run(
      (api) => api.statistics.statisticsGetQuickStats(),
      (response) => switch (response) {
        StatisticsGetQuickStatsResponse200(:final body) => body,
        StatisticsGetQuickStatsResponse401(:final body) => throwTonikHttp(
          401,
          body.message,
        ),
      },
    );
  }
}
