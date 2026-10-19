# Feature standards

This document describes the architecture and conventions that all features in this app follow. It exists so that new features can be added quickly and consistently by copying an existing feature's shape and behaviour. When you add a feature, follow these rules and give it a `README.md` (see [Documentation](#documentation)).

## Architecture overview

The app is organised **by feature** (`lib/features/<feature>/`), not by technical layer. Why:

- Everything needed to understand one feature lives in one folder. A newcomer (or you, six months from now) can read a feature top to bottom without jumping between global `widgets/`, `models/` and `services/` directories.
- Changes to a feature stay inside that feature. Features rarely need to know about each other, which keeps merge conflicts and accidental coupling low.
- Features are easy to grow (add a subflow, like `tickets/` did) or remove (delete the folder and its barrel import).
- Code is only promoted to shared locations (`core/`, `infrastructure/`) when it is *actually* shared. This prevents "shared everything" folders that nobody dares to touch.

Each feature has three layers, each in its own folder:

- **Presentation** (`presentation/bloc`, `presentation/screens`, `presentation/widgets`): UI and UI state. Screens render cubit states. They never talk to the API or storage directly.
- **Data** (`data/`): `data_providers/` wraps the generated API client and local storage, and a single coarse-grained `<feature>_repository.dart` combines them. The repository exposes `TaskEither<Failure, T>` (or `Stream<Either<Failure, T>>`) methods. Errors are captured as `Left`s, so callers never need try/catch.
- **Models** (`models/`): pure domain types (`Equatable` classes, domain enums, filter enums, failure types) with no Flutter or generated-API dependencies.

Cross-layer rules:

- Features depend on `core/` and `infrastructure/` but never on the *internals* of another feature (see [Folder layout and barrel files](#folder-layout-and-barrel-files)).
- Generated API types (`infrastructure/generated/`) never leak into `presentation/`. The repository maps them to domain models first, inline or in private helpers.
- `app/` wires everything together (router, dependency injection, auth navigation) and is the only place allowed to know about many features at once.

## Folder layout and barrel files

Each feature lives in `lib/features/<feature>/`:

```
<feature>/
├── data/                    # data_providers/ + <feature>_repository.dart
│   ├── data_providers/      # <name>_api.dart (API client wrappers),
│   │                        # <name>_local_store.dart (local persistence)
│   └── ...
├── models/                  # pure domain models and enums
├── presentation/
│   ├── bloc/                # cubits + their states (state is a `part of` the cubit)
│   ├── screens/             # full screens/pages
│   └── widgets/             # reusable widgets specific to the feature
├── <feature>.dart           # outermost barrel file
└── README.md                # feature documentation
```

- **Every subfolder gets a barrel file** that exports its contents: `data/data.dart`, `models/models.dart`, `presentation/presentation.dart`, `presentation/bloc/bloc.dart`, `presentation/screens/screens.dart` and `presentation/widgets/widgets.dart`. The outermost barrel (`<feature>.dart`) exports those barrels.
- **File naming**: files are named after what they contain, with a type suffix: `*_screen.dart`, `*_cubit.dart`, `*_state.dart`, `*_repository.dart`, `*_api.dart`, `*_local_store.dart`. Barrel files take their folder's name (`data.dart`, `models.dart`, `screens.dart`, ...).
- **Import rule:** outside a feature, you may only import that feature's *outermost* barrel:

  ```dart
  // Yes, anywhere in the app:
  import 'package:cafe_analog_app/features/tickets/tickets.dart';

  // No. Not outside the tickets feature:
  import 'package:cafe_analog_app/features/tickets/data/tickets_repository.dart';
  ```

  Inside a feature, import the closest barrel instead of individual files. This keeps features decoupled: their internals can move or be renamed without touching the rest of the app.
- `data_providers/` wraps the generated API client (`infrastructure/generated/`) and local storage. `_api.dart` files use `NetworkRequestExecutor`. `_local_store.dart` files return `TaskEither` with `LocalStorageFailure` on errors.
- Mapping from generated API types to domain models happens in the repository (`data/`), inline or in private helpers. Keep `models/` free of mapping logic.
- Feature-specific failures extend `Failure` from `core/failures.dart` and live in `models/`. For example, the sealed `PurchaseFailure` hierarchy in `tickets/models/`.
- Simple features without a cubit may stay flat (see `redeem_voucher/`).

## Feature to feature communication

Features only talk to each other through each other's public surface, never through internals. There are two mechanisms:

- **App-scoped cubits**: the common mechanism for triggering work in another feature. The cubit is app-scoped in `app/dependencies_provider.dart` (see [Cubit scoping](#cubit-scoping)) and the other feature calls it through `context.read<...>()`. For example, the tickets feature refreshes `ReceiptsCubit`, `QuickStatsCubit` and `LeaderboardCubit` after a ticket is used, and the redeem voucher flow refreshes `OwnedTicketsCubit`.
- **Shared repositories**: a feature may call another feature's repository directly through its barrel. For example, `redeem_voucher/` uses `TicketsRepository` without having its own data layer.

Rules:

- Use only the other feature's outermost barrel (see [Folder layout and barrel files](#folder-layout-and-barrel-files)). Data providers, local stores and other internals are never imported across features.
- If the same code is needed by more than one feature, prefer promoting it to `core/` over letting features depend on each other.
- Cross-feature calls go through the public surface only: a cubit's load/refresh methods or a repository's `TaskEither` methods.

## Cubits and states

### Naming

States use the `<Feature><Verb>` pattern:

| State                 | Purpose                                                                              |
| --------------------- | ------------------------------------------------------------------------------------ |
| `<Feature>Initial`    | Initial state. Every cubit starts here (`super(const <Feature>Initial())`)           |
| `<Feature>Loading`    | A fetch is in progress and no data is on screen                                      |
| `<Feature>Loaded`     | Data is on screen                                                                    |
| `<Feature>Refreshing` | A refresh is in progress. It **extends `<Feature>Loaded`** so the data stays visible |
| `<Feature>Failure`    | A fetch failed. It carries a `reason` field of type `String`                         |

- Every fetch cubit must have an `Initial` and a `Failure` state.
- States extend `Equatable`.
- The state file is a `part of` the cubit file, so the states are exported together with the cubit. Import the cubit (or the feature barrel) and the states are available; never import a state file directly.
- Flow cubits (that don't fetch a list of data, e.g. `PurchaseFlowCubit`) name their states after the flow steps instead (`Idle`, `Initiating`, `Initiated`, `Verifying`, `Completed`, `Failed`). This is an intentional exception to the pattern above.

### The load method

Every fetch cubit exposes a **single** method, conventionally named `load<Thing>()` (e.g. `loadQuickStats`, `loadLeaderboard`, `loadProducts`, `loadOwnedTickets`), that behaves as both an initial load and a refresh:

```dart
Future<void> loadQuickStats() async {
  final currentState = state;
  // 1. No-op while a fetch is already in flight.
  if (currentState is QuickStatsLoading || currentState is QuickStatsRefreshing) {
    return;
  }

  // 2. Keep data on screen when refreshing; show loading otherwise.
  if (currentState is QuickStatsLoaded) {
    emit(QuickStatsRefreshing(currentState.quickStats));
  } else {
    emit(const QuickStatsLoading());
  }

  // 3. Fetch and emit Loaded or Failure.
  await _repository
      .getQuickStats()
      .match(
        (failure) => emit(QuickStatsFailure(failure.reason)),
        (quickStats) => emit(QuickStatsLoaded(quickStats)),
      )
      .run();
}
```

If a cubit guards against overlapping fetches with a private in-flight flag, make sure the flag is reset in a `finally` block so an unexpected exception can never leave the cubit permanently blocked (see `OwnedTicketsCubit`).

## Refresh

The `Screen` widget has an `onRefresh` callback that calls the cubit's `load<Thing>()` method. This is the only place where pull-to-refresh is attached, so that failure states are refreshable too (see [Failure handling](#failure-handling)).

```dart
return Screen.listView(
  name: 'Tickets',
  onRefresh: () => context.read<OwnedTicketsCubit>().loadOwnedTickets(),
  children: [/* state-dependent content */],
);
```

## Failure handling

- A failed fetch emits `<Feature>Failure(reason)`. Loaded data is **replaced** by the failure state (we deliberately don't show stale data).
- Every failure state must render the shared `FailureMessage` widget (`lib/core/widgets/failure_message.dart`) with a `'Failed to load <thing>: $reason'` message and a retry callback that invokes the load method:

  ```dart
  OwnedTicketsFailure(:final reason) => FailureMessage(
    message: 'Failed to load tickets: $reason',
    onRetry: () => context.read<OwnedTicketsCubit>().loadOwnedTickets(),
  ),
  ```

- A feature must always be recoverable from a failure state: via the retry button, pull-to-refresh or both.

## API enum handling

The generated API client decodes enums with generated `<EnumName>FromJson` functions that have one important quirk: They match values case-insensitively and return `swaggerGeneratedUnknown` for unrecognised values.

Rules:

1. **Always** decode enum fields through the generated `<EnumName>FromJson` function (never switch on raw strings).
2. Treat `swaggerGeneratedUnknown` as an error that eventually results in a **failure state**. Never crash and never silently drop data.
3. Domain models must use their own domain enums, not the generated ones and not `String`s.
4. Import the generated client with an alias (`import ... as api;`) so its origin is obvious:
    ```
    import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
    ```

## Code generation

The HTTP API client in `lib/infrastructure/generated/` is generated from the Swagger specs in `swagger/`. It is **not** checked into git and must never be edited by hand.

- Fetch the latest specs with `make swagger`, then regenerate with `make generate`.
- The generated folder is excluded from the analyzer (see `analysis_options.yaml`).

## Cubit scoping

Scope cubits as low as possible:

- Scope cubits to the route/shell that uses them (in `app/router.dart`), like `OwnedTicketsCubit` and `TicketCatalogCubit` under `/tickets`.
- Keep cubits app-scoped (in `app/dependencies_provider.dart`) when they are needed outside their own screens:
  - before navigation exists (`AuthCubit`),
  - during router redirects (`PurchaseFlowCubit` is read in a redirect callback, which only has app-level context),
  - by widgets in **other** features (`ReceiptsCubit`, `QuickStatsCubit` and `LeaderboardCubit` are refreshed from the tickets feature after a ticket is used).
- Start the initial load in the cubit's `create` callback, e.g. `unawaited(cubit.loadOwnedTickets())`.

## Screens and widgets

- Use the shared `Screen` scaffold (`Screen.listView` with `onRefresh`, or `Screen.withBody`) for feature pages. The login screens intentionally use their own `Scaffold` layout.
- Render states with a `switch` over the sealed state class.
- Prefer separate files under `widgets/` over private `_Widget` classes when the composition grows beyond what a newcomer can read in one pass. Inline small pieces in the screen file.
- Shared widgets in `core/widgets/` use the `Analog` prefix (`AnalogAppBar`, `AnalogChoiceChips`, `AnalogForm`, ...) so they are recognisable as app-wide building blocks.
- Register new routes in `app/router.dart`, scoping route-local cubits there (see [Cubit scoping](#cubit-scoping)).

## Testing and quality

- Tests live in `test/`, mirroring the `lib/` layout where practical (`test/tickets/`, `test/core/`, `test/http/`). App-level tests (router, auth, app wiring) live at the `test/` root.
- Cubit tests use `bloc_test` and `mocktail` mocks of the repository (see `test/tickets/owned_tickets_cubit_test.dart`).
- Before pushing, run `make fix` (format + auto-fixes), `flutter analyze` and `flutter test`.
- CI (`.github/workflows/main.yaml`) runs the same checks: format, analyze, tests with coverage, plus a spell check over all Markdown files. PR titles must follow the conventional commits spec (semantic-pull-request workflow).

## Documentation

- Every feature gets a `README.md` describing the caveats that are not obvious from the code: subflows, WIP state, what is missing and intentional deviations from these standards.
- Update this document when a convention changes.
