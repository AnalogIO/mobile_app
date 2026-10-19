enum LeaderboardFilter { month, semester, allTime }

extension LeaderboardFilterX on LeaderboardFilter {
  String get label => switch (this) {
    LeaderboardFilter.month => 'This month',
    LeaderboardFilter.semester => 'This semester',
    LeaderboardFilter.allTime => 'All time',
  };
}
