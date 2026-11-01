# Settings

Profile card, account information, about, legal and logout.

## Caveats

- `ProfileCubit` is scoped to the `/settings` shell route (in `app/router.dart`),
  so both `SettingsScreen` and `YourProfileScreen` (a nested route) can read it.
  Its initial load is kicked off in the `create` callback.
- The profile is fetched with `GET /api/v2/account` and updated with
  `PUT /api/v2/account`. Editable fields are `name` (via `ChangeNameScreen`),
  `privacyActivated` (`Appear anonymous`), `email` (via `ChangeEmailScreen`)
  and `programmeId` (via `ChangeOccupationScreen`). The change screens reuse
  the shared `AnalogForm` with the current value pre-filled; the occupation
  screen is a list picker with the current programme marked.
- The list of programmes comes from `GET /api/v2/programmes`.
  `ProgrammesCubit` is scoped to the `/settings/change-occupation` route
  (in `app/router.dart`).
- `UserResponse.programme` is a typed `ProgrammeResponse` in the Tonik client;
  `SettingsRepository` maps it directly to the `UserProfile.occupation` label.
- Update methods (`updateName`, `updateEmail`, `updateAppearAnonymous`) never
  emit a failure state: they return `Either<Failure, UserProfile>` and only
  emit `ProfileLoaded` on success. Callers surface errors locally (the form's
  `setError` callback or a snackbar) so a failed edit never breaks the form
  page or the settings page. This mirrors how the voucher flow reports errors.
- Changing the email invalidates the current JWT, because the backend resolves
  the account from the JWT's email claim. `ChangeEmailScreen` therefore renews
  the session after a successful update via `AuthCubit.refreshSession()` (a
  silent refresh-token exchange). If the renewal fails, the user is logged out
  and asked to log in again with the new email.
- Changing the name or toggling `Appear anonymous` refreshes the app-scoped
  `LeaderboardCubit` (from the statistics feature), since both affect how the
  user is shown on the leaderboards.
- Opening hours (`OpeningHoursScreen`) show static, hardcoded data
  (`models/opening_hours.dart`): there is no backend endpoint for it, so it
  mirrors the old app's local data source. This is a flat feature with no
  cubit, like `redeem_voucher/`.
- Logout confirms via `showAnalogDialog` and then calls `AuthCubit.logOut`.
- Deleting the account (`DELETE /api/v2/account`) only *requests* deletion:
  the backend responds `202`, emails a verification link, and the account is
  anonymized when that link is opened. After a successful request the app
  logs the user out, since the session would otherwise break once the account
  no longer exists.
- Licenses open Flutter's built-in `LicensePage` (auto-generated from package
  licenses). The Privacy policy opens `https://www.cafeanalog.dk/privacy-policy`
  in an in-app browser via `url_launcher` (`LaunchMode.inAppBrowserView`, shared
  `_openExternalPage` helper). Keep this URL in sync with the App Store Connect /
  Play Console listings.
- Contact us opens the Cognito feedback form
  (`https://www.cognitoforms.com/CafeAnalog1/BugReport`). FAQ, Credits and
  opening hours are reachable from the About section.
- **Terms of service are not linked yet.** `https://www.cafeanalog.dk/terms`
  currently returns 404, so the tile was removed rather than shipping a broken
  link. Add it back once the page exists (tracked by mobile_app issue #41).
- The profile picture (icon + background color) is stored **locally** in
  `SharedPreferences` (`ProfilePictureLocalStore`), because the backend has no
  profile picture fields. When the backend gains `profilePictureId` and
  `profileBackgroundColor` (see the old app's `feature/change-profile-pic`
  branch), swap the local store for API calls in `SettingsRepository`. The
  picture is cleared together with the other user context on logout
  (`DependenciesProvider.clearAuthenticatedUserContext`).
