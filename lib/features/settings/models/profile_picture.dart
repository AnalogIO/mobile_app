import 'package:equatable/equatable.dart';

/// The user's chosen profile picture: a coffee icon on a colored background.
///
/// Both ids are indices into the palettes rendered by `UserIcon`
/// (`core/widgets/user_icon.dart`): [iconId] selects one of
/// `UserIcon.iconCount` icons and [backgroundColorId] selects one of
/// `UserIcon.colors`.
class ProfilePicture extends Equatable {
  const new({required this.iconId, required this.backgroundColorId});

  final int iconId;
  final int backgroundColorId;

  @override
  List<Object?> get props => [iconId, backgroundColorId];
}
