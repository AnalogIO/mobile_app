part of 'leaderboard_cubit.dart';

sealed class LeaderboardState extends Equatable {
  const new({required this.filter});
  final LeaderboardFilter filter;

  @override
  List<Object?> get props => [filter];
}

final class LeaderboardInitial extends LeaderboardState {
  const new({required super.filter});
}

final class LeaderboardLoading extends LeaderboardState {
  const new({required super.filter});
}

final class LeaderboardLoaded extends LeaderboardState {
  const new(this.leaderboard, {required super.filter});
  final List<LeaderboardUserEntry> leaderboard;

  @override
  List<Object?> get props => [filter, leaderboard];
}

final class LeaderboardRefreshing extends LeaderboardLoaded {
  const new(super.leaderboard, {required super.filter});
}

final class LeaderboardFailure extends LeaderboardState {
  const new(this.reason, {required super.filter});
  final String reason;

  @override
  List<Object?> get props => [filter, reason];
}
