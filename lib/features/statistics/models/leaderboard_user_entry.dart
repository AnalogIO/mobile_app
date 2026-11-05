import 'package:cafe_analog_app/core/profile_picture.dart';
import 'package:equatable/equatable.dart';

class LeaderboardUserEntry extends Equatable {
  const new({
    required this.userId,
    required this.name,
    required this.rank,
    required this.drinksConsumed,
    required this.isCurrentUser,
    required this.profilePicture,
  });

  final int userId;
  final String name;
  final int rank;
  final int drinksConsumed;
  final bool isCurrentUser;
  final ProfilePicture profilePicture;

  @override
  List<Object?> get props => [
    userId,
    name,
    rank,
    drinksConsumed,
    isCurrentUser,
    profilePicture,
  ];
}
