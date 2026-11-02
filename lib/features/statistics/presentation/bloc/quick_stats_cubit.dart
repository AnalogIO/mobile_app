import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:equatable/equatable.dart';

part 'quick_stats_state.dart';

class QuickStatsCubit extends Cubit<QuickStatsState> {
  new({required this._repository}) : super(const QuickStatsInitial());

  final StatisticsRepository _repository;

  Future<void> loadQuickStats() async {
    if (isClosed) return;

    final currentState = state;
    if (currentState is QuickStatsLoading ||
        currentState is QuickStatsRefreshing) {
      return;
    }

    if (currentState is QuickStatsLoaded) {
      emit(QuickStatsRefreshing(currentState.quickStats));
    } else {
      emit(const QuickStatsLoading());
    }

    final result = await _repository.getQuickStats().run();

    // The cubit is closed when the user logs out, which disposes the shell
    // while the request may still be in flight.
    if (isClosed) return;

    result.match(
      (error) => emit(QuickStatsFailure(error.reason)),
      (quickStats) => emit(QuickStatsLoaded(quickStats)),
    );
  }
}
