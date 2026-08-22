part of 'quick_stats_cubit.dart';

sealed class QuickStatsState extends Equatable {
  const QuickStatsState();
}

final class QuickStatsInitial extends QuickStatsState {
  const QuickStatsInitial();

  @override
  List<Object?> get props => [];
}

final class QuickStatsLoading extends QuickStatsState {
  const QuickStatsLoading();

  @override
  List<Object?> get props => [];
}

final class QuickStatsLoaded extends QuickStatsState {
  const QuickStatsLoaded(this.quickStats);

  final QuickStats quickStats;

  @override
  List<Object?> get props => [quickStats];
}

final class QuickStatsRefreshing extends QuickStatsLoaded {
  const QuickStatsRefreshing(super.quickStats);
}

final class QuickStatsFailure extends QuickStatsState {
  const QuickStatsFailure(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}
