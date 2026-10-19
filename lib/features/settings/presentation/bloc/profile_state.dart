part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  const new();
}

final class ProfileLoading extends ProfileState {
  const new();
}

final class ProfileLoaded extends ProfileState {
  const new(this.profile);

  final UserProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class ProfileRefreshing extends ProfileLoaded {
  const new(super.profile);
}

final class ProfileFailure extends ProfileState {
  const new({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
