import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

class LeaderboardApi {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  TaskEither<Failure, List<LeaderboardEntry>> fetchTopLeaderboard({
    required LeaderboardPreset preset,
  }) {
    return _executor.run(
      (api) => api.leaderboard.leaderboardGetTopEntries(preset: preset),
      (entries) => entries,
    );
  }

  TaskEither<Failure, LeaderboardEntry> fetchCurrentUserLeaderboardEntry({
    required LeaderboardPreset preset,
  }) {
    return _executor.run(
      (api) => api.leaderboard.leaderboardGet(preset: preset),
      (response) => switch (response) {
        LeaderboardGetResponse200(:final body) => body,
        LeaderboardGetResponse401() => throwTonikHttp(401),
      },
    );
  }
}
