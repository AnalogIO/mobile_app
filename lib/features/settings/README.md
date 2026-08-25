# Settings

Profile card, account information, about, legal and logout.

## Caveats

- **WIP.** The data is hardcoded and several actions are no-ops. There is no cubit or `data/`/`models/` layer yet. Presentation only for now.
- Logout confirms via `showAnalogDialog` and then calls `AuthCubit.logOut`.
