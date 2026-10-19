import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/settings/models/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the user's chosen profile picture locally.
///
/// The backend does not expose profile picture fields yet, so the picture is
/// stored on-device for now. When the backend gains `profilePictureId` and
/// `profileBackgroundColor` (as in the old app's `feature/change-profile-pic`
/// branch), swap this store for API calls in `SettingsRepository`.
class ProfilePictureLocalStore {
  const ProfilePictureLocalStore({required this._store});

  final SharedPreferencesWithCache _store;

  static const iconKey = 'profile_picture_icon_id';
  static const backgroundColorKey = 'profile_picture_background_color_id';

  /// Returns the stored profile picture, or `none()` when not set.
  Option<ProfilePicture> getProfilePicture() {
    final iconId = _store.getInt(iconKey);
    final backgroundColorId = _store.getInt(backgroundColorKey);
    if (iconId == null || backgroundColorId == null) {
      return none();
    }
    return some(
      ProfilePicture(iconId: iconId, backgroundColorId: backgroundColorId),
    );
  }

  TaskEither<Failure, Unit> saveProfilePicture(ProfilePicture picture) {
    return TaskEither.tryCatch(
      () async {
        await _store.setInt(iconKey, picture.iconId);
        await _store.setInt(backgroundColorKey, picture.backgroundColorId);
        return unit;
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }

  TaskEither<Failure, Unit> clear() {
    return TaskEither.tryCatch(
      () async {
        await _store.remove(iconKey);
        await _store.remove(backgroundColorKey);
        return unit;
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }
}
