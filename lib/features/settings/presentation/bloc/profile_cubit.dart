import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'profile_state.dart';

/// Cubit responsible for managing the current user's profile.
///
/// It fetches the profile from the backend and applies edits (name, email and
/// anonymous mode) back to it.
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this._repository}) : super(const ProfileInitial());

  final SettingsRepository _repository;

  /// Loads the profile, behaving as both an initial load and a refresh.
  Future<void> loadProfile() async {
    final currentState = state;
    if (currentState is ProfileLoading || currentState is ProfileRefreshing) {
      return;
    }

    if (currentState is ProfileLoaded) {
      emit(ProfileRefreshing(currentState.profile));
    } else {
      emit(const ProfileLoading());
    }

    await _repository
        .getProfile()
        .match(
          (failure) => emit(ProfileFailure(reason: failure.reason)),
          (profile) => emit(ProfileLoaded(profile)),
        )
        .run();
  }

  /// Updates the user's name.
  ///
  /// On success the updated profile is emitted. On failure no state is
  /// emitted (so the UI keeps showing the current profile) and the [Failure]
  /// is returned to the caller, which is responsible for surfacing it.
  Future<Either<Failure, Unit>> updateName(String name) {
    return _repository.updateName(name).map((profile) {
      emit(ProfileLoaded(profile));
      return unit;
    }).run();
  }

  /// Updates the user's email.
  ///
  /// See [updateName] for how successes and failures are handled.
  Future<Either<Failure, Unit>> updateEmail(String email) {
    return _repository.updateEmail(email).map((profile) {
      emit(ProfileLoaded(profile));
      return unit;
    }).run();
  }

  /// Updates the user's study programme (occupation).
  ///
  /// See [updateName] for how successes and failures are handled.
  Future<Either<Failure, Unit>> updateOccupation(int programmeId) {
    return _repository.updateProgramme(programmeId).map((profile) {
      emit(ProfileLoaded(profile));
      return unit;
    }).run();
  }

  /// Updates whether the user appears anonymously on the leaderboard.
  ///
  /// See [updateName] for how successes and failures are handled.
  Future<Either<Failure, Unit>> updateAppearAnonymous({
    required bool appearAnonymous,
  }) {
    return _repository
        .updateAppearAnonymous(appearAnonymous: appearAnonymous)
        .map((profile) {
          emit(ProfileLoaded(profile));
          return unit;
        })
        .run();
  }

  /// Requests deletion of the user's account.
  ///
  /// Emits no states: the account is only deleted once the verification email
  /// link is opened, and the caller (the settings screen) drives the follow-up
  /// flow. Returns [Left] with the failure if the request could not be sent.
  Future<Either<Failure, Unit>> requestAccountDeletion() {
    return _repository.requestAccountDeletion().run();
  }
}
