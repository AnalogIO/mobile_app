import 'dart:async';

import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockStatisticsRepository extends Mock implements StatisticsRepository;

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
}
