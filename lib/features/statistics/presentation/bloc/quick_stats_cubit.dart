import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:equatable/equatable.dart';

part 'quick_stats_state.dart';

class QuickStatsCubit extends Cubit<QuickStatsState> {
  QuickStatsCubit({required this._repository})
    : super(const QuickStatsInitial());

  final StatisticsRepository _repository;

  Future<void> loadQuickStats() async {
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

    await _repository
        .getQuickStats()
        .match(
          (error) => emit(QuickStatsFailure(error.reason)),
          (quickStats) => emit(QuickStatsLoaded(quickStats)),
        )
        .run();
  }
}
