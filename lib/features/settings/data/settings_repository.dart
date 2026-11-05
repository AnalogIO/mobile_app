import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/settings/data/data_providers/data_providers.dart';
import 'package:cafe_analog_app/features/settings/models/models.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
import 'package:fpdart/fpdart.dart';

/// Handles data operations related to the user's profile.
class SettingsRepository {
  const new({required this._accountApi, required this._programmesApi});

  final AccountApi _accountApi;
  final ProgrammesApi _programmesApi;

  /// Fetches the current user's profile.
  TaskEither<Failure, UserProfile> getProfile() {
    return _accountApi.getUser().map(_mapToProfile);
  }

  /// Updates the current user's name.
  TaskEither<Failure, UserProfile> updateName(String name) {
    final request = api.UpdateUserRequest(name: name);
    return _accountApi.updateUser(request).map(_mapToProfile);
  }

  /// Updates the current user's email.
  TaskEither<Failure, UserProfile> updateEmail(String email) {
    final request = api.UpdateUserRequest(email: email);
    return _accountApi.updateUser(request).map(_mapToProfile);
  }

  /// Updates the current user's study programme (occupation).
  TaskEither<Failure, UserProfile> updateProgramme(int programmeId) {
    final request = api.UpdateUserRequest(programmeId: programmeId);
    return _accountApi.updateUser(request).map(_mapToProfile);
  }

  /// Updates whether the current user appears anonymously on the leaderboard.
  TaskEither<Failure, UserProfile> updateAppearAnonymous({
    required bool appearAnonymous,
  }) {
    final request = api.UpdateUserRequest(privacyActivated: appearAnonymous);
    return _accountApi.updateUser(request).map(_mapToProfile);
  }

  /// Requests deletion of the current user's account.
  ///
  /// This only initiates the deletion: the backend sends a verification email
  /// and the account is anonymized when the link in that email is opened.
  TaskEither<Failure, Unit> requestAccountDeletion() {
    return _accountApi.requestAccountDeletion();
  }

  /// Updates the user's chosen profile picture.
  TaskEither<Failure, UserProfile> updateProfilePicture(
    ProfilePicture picture,
  ) {
    final request = api.UpdateUserRequest(
      profileIcon: api.ProfileIcon.values[picture.iconId],
      profileBackgroundColor:
          api.ProfileBackgroundColor.values[picture.backgroundColorId],
    );
    return _accountApi.updateUser(request).map(_mapToProfile);
  }

  /// Fetches the list of available study programmes (occupations).
  TaskEither<Failure, List<Programme>> getProgrammes() {
    return _programmesApi.fetchProgrammes().map(
      (programmes) => programmes
          .map(
            (programme) => Programme(
              id: programme.id,
              shortName: programme.shortName,
              fullName: programme.fullName,
            ),
          )
          .toList(),
    );
  }

  /// Maps a generated [api.UserResponse] to a domain [UserProfile].
  UserProfile _mapToProfile(api.UserResponse response) {
    final programme = response.programme;
    return UserProfile(
      id: response.id,
      name: response.name,
      email: response.email,
      occupation: programme.fullName.isNotEmpty
          ? programme.fullName
          : programme.shortName,
      programmeId: programme.id,
      appearAnonymous: response.privacyActivated,
      // The generated enums preserve the backend enum order, which is also the
      // order of the icon assets and the palette in `UserIcon`.
      profilePicture: ProfilePicture(
        iconId: response.profileIcon.index,
        backgroundColorId: response.profileBackgroundColor.index,
      ),
    );
  }
}
