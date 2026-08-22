import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit({required this._repository})
    : super(const LeaderboardLoading(filter: LeaderboardFilter.month));

  final StatisticsRepository _repository;

  Future<void> setFilter(LeaderboardFilter filter) async {
    if (state is LeaderboardLoading) {
      return;
    }
    emit(LeaderboardLoading(filter: filter));
    await loadLeaderboard();
  }

  Future<void> loadLeaderboard() async {
    final filter = state.filter;

    return _repository
        .getLeaderboard(filter: filter)
        .match(
          (error) => emit(LeaderboardError(error.reason, filter: filter)),
          (leaderboard) => emit(LeaderboardLoaded(leaderboard, filter: filter)),
        )
        .run();
  }
}
