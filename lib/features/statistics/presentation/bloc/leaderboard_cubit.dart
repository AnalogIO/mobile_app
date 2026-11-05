import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  new({required this._repository})
    : super(const LeaderboardInitial(filter: LeaderboardFilter.month));

  final StatisticsRepository _repository;

  /// Whether a load was requested while another one was in flight.
  ///
  /// App-scoped callers (for example the settings feature after a profile
  /// change) can request a refresh at any time. Keep a single request queued
  /// so their change is not missed, then run it once the in-flight load
  /// settles.
  bool _refreshQueued = false;

  /// Loads the leaderboard for the currently selected filter.
  ///
  /// Behaves as both an initial load and a refresh: if data is already
  /// loaded, it is kept on screen while fresh data is fetched.
  Future<void> loadLeaderboard() async {
    if (isClosed) return;

    final currentState = state;
    if (currentState is LeaderboardLoading ||
        currentState is LeaderboardRefreshing) {
      _refreshQueued = true;
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
    if (isClosed) return;

    if (state is LeaderboardLoading) {
      return;
    }
    emit(LeaderboardLoading(filter: filter));
    await _fetchLeaderboard(filter);
  }

  Future<void> _fetchLeaderboard(LeaderboardFilter filter) async {
    final result = await _repository.getLeaderboard(filter: filter).run();

    // The cubit is closed when the user logs out, which disposes the shell
    // while the request may still be in flight.
    if (isClosed) return;

    result.match(
      (failure) => emit(LeaderboardFailure(failure.reason, filter: filter)),
      (leaderboard) => emit(LeaderboardLoaded(leaderboard, filter: filter)),
    );

    if (!_refreshQueued) return;
    _refreshQueued = false;
    await loadLeaderboard();
  }
}
