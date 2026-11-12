import 'dart:async';

import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/core/profile_picture.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockStatisticsRepository extends Mock implements StatisticsRepository;

const _entry = LeaderboardUserEntry(
  userId: 1,
  name: 'Alice',
  rank: 1,
  drinksConsumed: 10,
  isCurrentUser: false,
  profilePicture: ProfilePicture(iconId: 0, backgroundColorId: 8),
);

void main() {
  late _MockStatisticsRepository repository;

  setUp(() {
    repository = _MockStatisticsRepository();
  });

  test('quick stats ignores a response that arrives after disposal', () async {
    final response = Completer<Either<Failure, QuickStats>>();
    when(
      () => repository.getQuickStats(),
    ).thenAnswer((_) => TaskEither<Failure, QuickStats>(() => response.future));

    final cubit = QuickStatsCubit(repository: repository);

    final load = cubit.loadQuickStats();
    await cubit.close();
    response.complete(left<Failure, QuickStats>(const ConnectionFailure()));

    await expectLater(load, completes);
  });

  test('leaderboard ignores a response that arrives after disposal', () async {
    final response = Completer<Either<Failure, List<LeaderboardUserEntry>>>();
    when(() => repository.getLeaderboard(filter: LeaderboardFilter.month))
        .thenAnswer(
          (_) => TaskEither<Failure, List<LeaderboardUserEntry>>(
            () => response.future,
          ),
        );

    final cubit = LeaderboardCubit(repository: repository);

    final load = cubit.loadLeaderboard();
    await cubit.close();
    response.complete(
      left<Failure, List<LeaderboardUserEntry>>(const ConnectionFailure()),
    );

    await expectLater(load, completes);
  });

  test(
    'leaderboard queues a refresh requested while a load is in flight',
    () async {
      final response = Completer<Either<Failure, List<LeaderboardUserEntry>>>();
      var calls = 0;
      when(() => repository.getLeaderboard(filter: LeaderboardFilter.month))
          .thenAnswer((_) {
            calls++;
            if (calls == 1) {
              return TaskEither<Failure, List<LeaderboardUserEntry>>(
                () => response.future,
              );
            }
            return TaskEither.right(const [_entry]);
          });

      final cubit = LeaderboardCubit(repository: repository);
      addTearDown(cubit.close);

      final load = cubit.loadLeaderboard();
      unawaited(cubit.loadLeaderboard());

      response.complete(
        right<Failure, List<LeaderboardUserEntry>>(const [_entry]),
      );
      await load;

      expect(calls, 2);
      expect(
        cubit.state,
        const LeaderboardLoaded([_entry], filter: LeaderboardFilter.month),
      );

      // The queued request was consumed: the next load fetches again.
      await cubit.loadLeaderboard();
      expect(calls, 3);
    },
  );

  test('leaderboard runs a queued refresh after a failed load', () async {
    final response = Completer<Either<Failure, List<LeaderboardUserEntry>>>();
    var calls = 0;
    when(() => repository.getLeaderboard(filter: LeaderboardFilter.month))
        .thenAnswer((_) {
          calls++;
          if (calls == 1) {
            return TaskEither<Failure, List<LeaderboardUserEntry>>(
              () => response.future,
            );
          }
          return TaskEither.right(const [_entry]);
        });

    final cubit = LeaderboardCubit(repository: repository);
    addTearDown(cubit.close);

    final load = cubit.loadLeaderboard();
    unawaited(cubit.loadLeaderboard());

    response.complete(
      left<Failure, List<LeaderboardUserEntry>>(const ConnectionFailure()),
    );
    await load;

    expect(calls, 2);
    expect(cubit.state, isA<LeaderboardLoaded>());
  });

  test(
    'leaderboard refresh queued during a filter change uses that filter',
    () async {
      final response = Completer<Either<Failure, List<LeaderboardUserEntry>>>();
      var calls = 0;
      when(() => repository.getLeaderboard(filter: LeaderboardFilter.semester))
          .thenAnswer((_) {
            calls++;
            if (calls == 1) {
              return TaskEither<Failure, List<LeaderboardUserEntry>>(
                () => response.future,
              );
            }
            return TaskEither.right(const [_entry]);
          });

      final cubit = LeaderboardCubit(repository: repository);
      addTearDown(cubit.close);

      final load = cubit.setFilter(LeaderboardFilter.semester);
      unawaited(cubit.loadLeaderboard());

      response.complete(
        right<Failure, List<LeaderboardUserEntry>>(const [_entry]),
      );
      await load;

      expect(calls, 2);
      expect(
        cubit.state,
        const LeaderboardLoaded([_entry], filter: LeaderboardFilter.semester),
      );
    },
  );
}
