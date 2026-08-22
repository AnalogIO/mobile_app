part of 'leaderboard_cubit.dart';

sealed class LeaderboardState extends Equatable {
  const LeaderboardState({required this.filter});
  final LeaderboardFilter filter;

  @override
  List<Object?> get props => [filter];
}

final class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading({required super.filter});
}

final class LeaderboardLoaded extends LeaderboardState {
  const LeaderboardLoaded(this.leaderboard, {required super.filter});
  final List<LeaderboardUserEntry> leaderboard;

  @override
  List<Object?> get props => [filter, leaderboard];
}

final class LeaderboardError extends LeaderboardState {
  const LeaderboardError(this.errorMessage, {required super.filter});
  final String errorMessage;

  @override
  List<Object?> get props => [filter, errorMessage];
}
