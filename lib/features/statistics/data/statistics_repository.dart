import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class StatisticsRepository {
  const StatisticsRepository({
    required this._leaderboardApi,
    required this._quickStatsApi,
  });

  final LeaderboardApi _leaderboardApi;
  final QuickStatsApi _quickStatsApi;

  /// Fetches the leaderboard entries based on the provided [filter].
  ///
  /// This method retrieves both the top 10 entries and the current user's
  /// entry, then merges them to ensure the current user's entry is always
  /// included in the result.
  TaskEither<Failure, List<LeaderboardUserEntry>> getLeaderboard({
    required LeaderboardFilter filter,
  }) {
    final preset = switch (filter) {
      LeaderboardFilter.month => api.LeaderboardPreset.month,
      LeaderboardFilter.semester => api.LeaderboardPreset.semester,
      LeaderboardFilter.allTime => api.LeaderboardPreset.total,
    };

    return _leaderboardApi
        .fetchTopLeaderboard(preset: preset)
        .flatMap(
          (topEntries) => _leaderboardApi
              .fetchCurrentUserLeaderboardEntry(preset: preset)
              .map(
                (currentUserEntry) {
                  final currentUserId = currentUserEntry.id;
                  final currentUserInTop = topEntries.any(
                    (entry) => entry.id == currentUserId,
                  );

                  // If the current user's entry is not in the top entries,
                  // we add it to the list.
                  final allEntries = currentUserInTop
                      ? topEntries
                      : [...topEntries, currentUserEntry];

                  return allEntries
                      .map(
                        (entry) => LeaderboardUserEntry(
                          userId: entry.id!,
                          name: entry.name!,
                          rank: entry.rank!,
                          drinksConsumed: entry.score!,
                          isCurrentUser: entry.id == currentUserId,
                        ),
                      )
                      .sortedBy((entry) => entry.rank);
                },
              ),
        );
  }

  /// Fetches the quick stats.
  TaskEither<Failure, QuickStats> getQuickStats() {
    return _quickStatsApi.fetchQuickStats().flatMap((statDtos) {
      int? allTimeDrinksConsumed;
      int? todayDrinksConsumed;
      (int count, String drinkName)? allTimeFavouriteDrink;
      int? weekDrinksConsumed;

      for (final dto in statDtos) {
        switch (api.quickStatTypeFromJson(dto.key)) {
          case api.QuickStatType.totaldrinks:
            allTimeDrinksConsumed = dto.value;
          case api.QuickStatType.drinkstoday:
            todayDrinksConsumed = dto.value;
          case api.QuickStatType.favouritedrink:
            allTimeFavouriteDrink = (dto.value, dto.supportingText ?? '');
          case api.QuickStatType.drinksthisweek:
            weekDrinksConsumed = dto.value;
          case api.QuickStatType.swaggerGeneratedUnknown:
            return TaskEither.left(
              const UnexpectedFailure('Received an unknown quick statistic'),
            );
        }
      }

      if (allTimeDrinksConsumed == null ||
          todayDrinksConsumed == null ||
          allTimeFavouriteDrink == null ||
          weekDrinksConsumed == null) {
        return TaskEither.left(
          const UnexpectedFailure('Received incomplete quick statistics'),
        );
      }

      return TaskEither.right(
        QuickStats(
          allTimeDrinksConsumed: allTimeDrinksConsumed,
          todayDrinksConsumedITU: todayDrinksConsumed,
          allTimeFavouriteDrink: allTimeFavouriteDrink,
          weekDrinksConsumed: weekDrinksConsumed,
        ),
      );
    });
  }
}
