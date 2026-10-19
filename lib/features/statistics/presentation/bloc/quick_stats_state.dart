part of 'quick_stats_cubit.dart';

sealed class QuickStatsState extends Equatable {
  const new();
}

final class QuickStatsInitial extends QuickStatsState {
  const new();

  @override
  List<Object?> get props => [];
}

final class QuickStatsLoading extends QuickStatsState {
  const new();

  @override
  List<Object?> get props => [];
}

final class QuickStatsLoaded extends QuickStatsState {
  const new(this.quickStats);

  final QuickStats quickStats;

  @override
  List<Object?> get props => [quickStats];
}

final class QuickStatsRefreshing extends QuickStatsLoaded {
  const new(super.quickStats);
}

final class QuickStatsFailure extends QuickStatsState {
  const new(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}
