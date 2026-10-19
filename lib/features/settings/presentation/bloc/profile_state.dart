part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.profile);

  final UserProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class ProfileRefreshing extends ProfileLoaded {
  const ProfileRefreshing(super.profile);
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
