import 'package:equatable/equatable.dart';

class LeaderboardUserEntry extends Equatable {
  const LeaderboardUserEntry({
    required this.userId,
    required this.name,
    required this.rank,
    required this.drinksConsumed,
    required this.isCurrentUser,
  });

  final int userId;
  final String name;
  final int rank;
  final int drinksConsumed;
  final bool isCurrentUser;

  @override
  List<Object?> get props => [
    userId,
    name,
    rank,
    drinksConsumed,
    isCurrentUser,
  ];
}
