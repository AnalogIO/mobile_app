part of 'profile_picture_cubit.dart';

sealed class ProfilePictureState extends Equatable {
  const ProfilePictureState();

  @override
  List<Object?> get props => [];
}

final class ProfilePictureInitial extends ProfilePictureState {
  const ProfilePictureInitial();
}

final class ProfilePictureLoading extends ProfilePictureState {
  const ProfilePictureLoading();
}

/// [picture] is `none()` when the user has not chosen a profile picture yet;
/// `UserIcon` then falls back to deriving one from the user id.
final class ProfilePictureLoaded extends ProfilePictureState {
  const ProfilePictureLoaded(this.picture);

  final Option<ProfilePicture> picture;

  @override
  List<Object?> get props => [picture];
}

final class ProfilePictureRefreshing extends ProfilePictureLoaded {
  const ProfilePictureRefreshing(super.picture);
}

final class ProfilePictureFailure extends ProfilePictureState {
  const ProfilePictureFailure({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
