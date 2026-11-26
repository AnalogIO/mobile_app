import 'package:equatable/equatable.dart';

/// The user's chosen profile picture: a coffee icon on a colored background.
///
/// Both ids are indices into the palettes rendered by `UserIcon`
/// (`core/widgets/user_icon.dart`): [iconId] selects one of
/// `UserIcon.iconCount` icons and [backgroundColorId] selects one of
/// `UserIcon.colors`.
///
/// The indices are also the ordinals of the backend's `ProfileIcon` and
/// `ProfileBackgroundColor` enums. The repositories map between the two, so
/// the icon assets and the background palette must stay in the same order as
/// the backend enums.
class ProfilePicture extends Equatable {
  const new({required this.iconId, required this.backgroundColorId});

  final int iconId;
  final int backgroundColorId;

  @override
  List<Object?> get props => [iconId, backgroundColorId];
}
