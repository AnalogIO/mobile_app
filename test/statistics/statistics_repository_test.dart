import 'package:cafe_analog_app/core/profile_picture.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockLeaderboardApi extends Mock implements LeaderboardApi;

class _MockQuickStatsApi extends Mock implements QuickStatsApi;

void main() {
  late _MockLeaderboardApi leaderboardApi;
  late StatisticsRepository repository;

  const topEntry = api.LeaderboardEntry(
    id: 1,
    name: 'Alice',
    rank: 1,
    profileIcon: api.ProfileIcon.coffeeCup,
    profileBackgroundColor: api.ProfileBackgroundColor.mossGreen,
    score: 25,
  );
  const currentUser = api.LeaderboardEntry(
    id: 99,
    name: 'You',
    rank: 0,
    profileIcon: api.ProfileIcon.teabag,
    profileBackgroundColor: api.ProfileBackgroundColor.aqua,
    score: 0,
  );

  setUp(() {
    leaderboardApi = _MockLeaderboardApi();
    repository = StatisticsRepository(
      leaderboardApi: leaderboardApi,
      quickStatsApi: _MockQuickStatsApi(),
    );
  });

  test(
    'puts the current user at the bottom when they are not in the top',
    () async {
      when(
        () => leaderboardApi.fetchTopLeaderboard(
          preset: api.LeaderboardPreset.month,
        ),
      ).thenAnswer((_) => TaskEither.right([topEntry]));
      when(
        () => leaderboardApi.fetchCurrentUserLeaderboardEntry(
          preset: api.LeaderboardPreset.month,
        ),
      ).thenAnswer((_) => TaskEither.right(currentUser));

      final result = await repository
          .getLeaderboard(filter: LeaderboardFilter.month)
          .run();

      final entries = result.getOrElse((_) => fail('Expected a leaderboard'));
      expect(entries.map((entry) => entry.userId), [1, 99]);
      expect(entries.last.isCurrentUser, isTrue);
      expect(entries.last.rank, 0);
      expect(
        entries.first.profilePicture,
        // `coffeeCup` is the 1st icon and `mossGreen` the 9th color.
        const ProfilePicture(iconId: 0, backgroundColorId: 8),
      );
      expect(
        entries.last.profilePicture,
        // `teabag` is the 10th icon and `aqua` the 8th color.
        const ProfilePicture(iconId: 9, backgroundColorId: 7),
      );
    },
  );

  test(
    'sorts the top entries and does not duplicate the current user',
    () async {
      const currentUserInTop = api.LeaderboardEntry(
        id: 99,
        name: 'You',
        rank: 2,
        profileIcon: api.ProfileIcon.teabag,
        profileBackgroundColor: api.ProfileBackgroundColor.aqua,
        score: 25,
      );
      when(
        () => leaderboardApi.fetchTopLeaderboard(
          preset: api.LeaderboardPreset.month,
        ),
      ).thenAnswer((_) => TaskEither.right([currentUserInTop, topEntry]));
      when(
        () => leaderboardApi.fetchCurrentUserLeaderboardEntry(
          preset: api.LeaderboardPreset.month,
        ),
      ).thenAnswer((_) => TaskEither.right(currentUserInTop));

      final result = await repository
          .getLeaderboard(filter: LeaderboardFilter.month)
          .run();

      final entries = result.getOrElse((_) => fail('Expected a leaderboard'));
      // The API returns the current user first, but rank 1 must come first.
      expect(entries.map((entry) => entry.userId), [1, 99]);
      expect(entries.where((entry) => entry.isCurrentUser), hasLength(1));
    },
  );
}
