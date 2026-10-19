import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'profile_picture_state.dart';

/// Cubit responsible for the user's profile picture (icon and background
/// color).
///
/// The picture is persisted locally for now, until the backend supports it.
class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  ProfilePictureCubit({required this._repository})
    : super(const ProfilePictureInitial());

  final SettingsRepository _repository;

  /// Loads the profile picture, behaving as both an initial load and a
  /// refresh.
  Future<void> loadProfilePicture() async {
    final currentState = state;
    if (currentState is ProfilePictureLoading ||
        currentState is ProfilePictureRefreshing) {
      return;
    }

    if (currentState is ProfilePictureLoaded) {
      emit(ProfilePictureRefreshing(currentState.picture));
    } else {
      emit(const ProfilePictureLoading());
    }

    await _repository
        .getProfilePicture()
        .match(
          (failure) => emit(ProfilePictureFailure(reason: failure.reason)),
          (picture) => emit(ProfilePictureLoaded(picture)),
        )
        .run();
  }

  /// Saves the chosen [picture].
  ///
  /// On success the loaded state is updated. On failure no state is emitted
  /// and the [Failure] is returned to the caller, which surfaces it.
  Future<Either<Failure, Unit>> setProfilePicture(ProfilePicture picture) {
    return _repository.saveProfilePicture(picture).map((_) {
      emit(ProfilePictureLoaded(some(picture)));
      return unit;
    }).run();
  }
}
