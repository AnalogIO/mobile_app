# Login

Authentication via magic links.

## Caveats

- Auth flow, not a fetch: `AuthCubit` states are named after the authentication lifecycle (`AuthAuthenticated`, `AuthEmailSent`, ...), not the `<Feature><Verb>` fetch pattern.
- `AuthNavigator` (a widget, not a screen) drives navigation, shows the loading overlay during `AuthLoading` and shows a snackbar on `AuthFailure`. Failure recovery happens here: it navigates to `/login` where the user can simply try again.
- The login screens intentionally use their own `Scaffold` layout instead of the shared `Screen` widget.
- `AuthCubitHandle` breaks the dependency cycle between the HTTP layer and `AuthCubit`: `TokenRefreshAuthenticator` is constructed before the cubit exists, so both share this handle and calls are queued until the cubit binds.
