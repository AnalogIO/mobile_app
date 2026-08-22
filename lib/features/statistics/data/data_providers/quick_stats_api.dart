import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

// Dummy class for quick stats
// (should be auto generated when the API is updated)
// FIXME: Remove this class when the API is updated to include quick stats
class QuickStat {
  const QuickStat({
    required this.key,
    required this.value,
    required this.title,
    required this.supportingText,
  });

  final String key;
  final int value;
  final String title;
  final String supportingText;
}

class QuickStatsApi {
  const QuickStatsApi({required this._executor});

  final NetworkRequestExecutor _executor;

  TaskEither<Failure, List<QuickStat>> fetchQuickStats() {
    // FIXME: Call the generated endpoint when API is updated
    throw UnimplementedError('Quick stats endpoint is not yet implemented');
    // return _executor.run((api) => api.v2.quickStatsGet());
  }
}
