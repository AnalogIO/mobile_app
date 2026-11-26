import 'package:cafe_analog_app/core/profile_picture.dart';
import 'package:equatable/equatable.dart';

/// The current user's profile as displayed in the settings.
class UserProfile extends Equatable {
  const new({
    required this.id,
    required this.name,
    required this.email,
    required this.occupation,
    required this.programmeId,
    required this.appearAnonymous,
    required this.profilePicture,
  });

  final int id;
  final String name;
  final String email;

  /// The user's study programme (e.g. "Software Development"), or
  /// an empty string when the user has no programme.
  final String occupation;

  /// Id of the user's study programme, or null when the user has none.
  final int? programmeId;

  /// Whether the user's name is hidden from the leaderboard.
  final bool appearAnonymous;

  /// The icon and background color shown for the user.
  final ProfilePicture profilePicture;

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    occupation,
    programmeId,
    appearAnonymous,
    profilePicture,
  ];
}
