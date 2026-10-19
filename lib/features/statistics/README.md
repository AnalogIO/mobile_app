# Statistics

Quick stats and leaderboards.

## Caveats

- `LeaderboardCubit.setFilter` intentionally drops the loaded data and shows `LeaderboardLoading` (the data about to be shown is different). This is an exception to the refresh standard.
- Both cubits are app-scoped (in `app/dependencies_provider.dart`) because the tickets feature refreshes them after a ticket is used.
- Pull-to-refresh is attached once at the `Screen` level and reloads both cubits. Each section widget owns the `BlocBuilder` for its cubit.
- The repository merges the top-10 leaderboard with the current user's entry so the user always appears, sorted by rank.
