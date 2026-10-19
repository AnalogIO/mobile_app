import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit({required this._repository})
    : super(const LeaderboardInitial(filter: LeaderboardFilter.month));

  final StatisticsRepository _repository;

  /// Loads the leaderboard for the currently selected filter.
  ///
  /// Behaves as both an initial load and a refresh: if data is already
  /// loaded, it is kept on screen while fresh data is fetched.
  Future<void> loadLeaderboard() async {
    final currentState = state;
    if (currentState is LeaderboardLoading ||
        currentState is LeaderboardRefreshing) {
      return;
    }

    if (currentState is LeaderboardLoaded) {
      emit(
        LeaderboardRefreshing(
          currentState.leaderboard,
          filter: currentState.filter,
        ),
      );
    } else {
      emit(LeaderboardLoading(filter: currentState.filter));
    }

    await _fetchLeaderboard(currentState.filter);
  }

  /// Changes the selected filter and loads the leaderboard for it.
  ///
  /// Unlike [loadLeaderboard], this drops any currently loaded data and
  /// shows a loading state, since the data about to be shown is different.
  Future<void> setFilter(LeaderboardFilter filter) async {
    if (state is LeaderboardLoading) {
      return;
    }
    emit(LeaderboardLoading(filter: filter));
    await _fetchLeaderboard(filter);
  }

  Future<void> _fetchLeaderboard(LeaderboardFilter filter) {
    return _repository
        .getLeaderboard(filter: filter)
        .match(
          (failure) => emit(LeaderboardFailure(failure.reason, filter: filter)),
          (leaderboard) => emit(LeaderboardLoaded(leaderboard, filter: filter)),
        )
        .run();
  }
}
