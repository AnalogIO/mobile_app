part of 'leaderboard_cubit.dart';

sealed class LeaderboardState extends Equatable {
  const LeaderboardState({required this.filter});
  final LeaderboardFilter filter;

  @override
  List<Object?> get props => [filter];
}

final class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial({required super.filter});
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

final class LeaderboardRefreshing extends LeaderboardLoaded {
  const LeaderboardRefreshing(super.leaderboard, {required super.filter});
}

final class LeaderboardFailure extends LeaderboardState {
  const LeaderboardFailure(this.reason, {required super.filter});
  final String reason;

  @override
  List<Object?> get props => [filter, reason];
}
