import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

class LeaderboardApi {
  const LeaderboardApi({required this._executor});

  final NetworkRequestExecutor _executor;

  TaskEither<Failure, List<LeaderboardEntry>> fetchTopLeaderboard({
    required LeaderboardPreset preset,
  }) {
    return _executor.run(
      (api) => api.v2.leaderboardTopGet(preset: preset.value, top: 10),
    );
  }

  TaskEither<Failure, LeaderboardEntry> fetchCurrentUserLeaderboardEntry({
    required LeaderboardPreset preset,
  }) {
    return _executor.run((api) => api.v2.leaderboardGet(preset: preset.value));
  }
}
