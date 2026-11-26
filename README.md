# Café Analog Coffee Card App

The digital coffee clip card app for Café Analog (the ITU coffee bar). Users buy bundles of tickets with MobilePay, spend a ticket on a drink of their choice and show the receipt as a valid payment.

![coverage][coverage_badge]

## Getting started

The Flutter SDK version is pinned per project with [FVM](https://fvm.app) in [`.fvmrc`](.fvmrc), so every developer, editor and CI job builds with exactly the same Flutter and Dart versions. [Install FVM](https://fvm.app/documentation/getting-started/installation) once, then let it install the pinned SDK:

```sh
make setup
```

Run `make setup` again after pulling a commit that bumps the version. Every Make target runs Flutter and Dart through FVM, so there is no SDK to switch by hand.

Run `make` (or `make help`) to see all available commands.

```sh
make get        # Install dependencies
make api        # Regenerate the API client (see Code generation)
```

Then launch the app from your editor (see Editors below), or:

```sh
fvm flutter run --flavor development   # against the dev backend
fvm flutter run --flavor production    # production app id, name and deep link scheme
```

There are two flavours: `development` and `production`. They differ in application id, display name, deep link scheme and backend:

| Flavour | Backend | Android application id | iOS bundle id |
| --- | --- | --- | --- |
| `development` | `https://core.dev.analogio.dk` | `dk.analogio.analog.dev` | `dk.analogio.analog.dev` |
| `production` | `https://core.prd.analogio.dk` | `dk.analog.digitalclipcard` | `DK.AnalogIO.DigitalCoffeeCard` |

The production ids match the old `coffeecard_app`, so the new app ships as an update to the existing listing instead of a new app. The backend is selected in [`lib/core/environment.dart`](lib/core/environment.dart); for a local backend, override it without editing code:

```sh
fvm flutter run --flavor development --dart-define=API_BASE_URL=http://192.168.1.10:5080
```

## Flutter version

The pinned version lives in [`.fvmrc`](.fvmrc) and is the only place it is maintained:

- Makefile targets run `fvm flutter` and `fvm dart`, so they always use the pinned SDK.
- Editors: `make setup` makes FVM point VS Code's Dart/Flutter extension at the pinned SDK in `.vscode/settings.json` (reload the window to pick it up); in IntelliJ / Android Studio, select `.fvm/flutter_sdk` as the project Flutter SDK.
- CI reads the version out of `.fvmrc` before installing Flutter, so there is no version to keep in sync in the workflow.

`pubspec.yaml` pins the same version in `environment.flutter`, so `pub get` fails loudly if a different SDK is used by accident. To bump Flutter, pick a release from the [archive](https://docs.flutter.dev/release/archive) and pin it:

```sh
fvm install <version>    # download the new SDK, e.g. `fvm install 3.51.0`
fvm use <version>        # pin it in .fvmrc and point the editor at it
```

Then update `environment.flutter` (the exact version) and `environment.sdk` (the Dart version, printed by `fvm flutter --version`) in `pubspec.yaml`, and run `make get`. Commit the resulting `.fvmrc` and `pubspec.yaml` changes, together with any Gradle bumps the new template requires (see [CONTRIBUTING.md](CONTRIBUTING.md)).

## Make targets 🛠

| Command                      | What it does                                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------------------------ |
| `make` / `make help`         | Show the help message listing all targets (default target)                                       |
| `make setup`                 | Install the pinned Flutter SDK (`fvm install`) and fetch dependencies                            |
| `make get`                   | Install dependencies (`fvm flutter pub get`)                                                     |
| `make api`                   | Regenerate the Tonik API client from the committed v2 spec                                       |
| `make api-update`            | Fetch the latest v2 spec, then regenerate the client                                             |
| `make api-check`             | Regenerate and fail if the committed client drifted (used by CI)                                 |
| `make swagger`               | Fetch the latest v2 OpenAPI spec from the backend into `swagger/`                                |
| `make clean`                 | Reset the project: `fvm flutter clean`, then `fvm flutter pub get`                               |
| `make upgrade-deps`          | Upgrade dependencies to latest majors (`fvm flutter pub upgrade --major-versions`)               |
| `make coverage`              | Run `fvm flutter test --coverage` and generate an HTML report in `coverage/html/`                |
| `make check`                 | Run the checks CI runs locally: format check, `fvm flutter analyze`, `fvm flutter test`          |
| `make fix`                   | Format code and apply automatic fixes (`fvm dart format .`, `fvm dart fix --apply`)              |

## Editors 💻

- **VS Code** is the preferred editor. The repository includes workspace configuration in `.vscode/` (launch configurations for the development flavour, recommended extensions for Dart/Flutter and the Bloc extension). After `make setup`, FVM writes the pinned SDK path into `.vscode/settings.json` (that file is not tracked in git); reload the window if the Dart/Flutter extension still uses another SDK.
- **IntelliJ / Android Studio** is also supported: the `.run/` directory contains run configurations for the development and production flavours. Set the project Flutter SDK to `.fvm/flutter_sdk` (created by `make setup`) so the IDE uses the pinned version too.

## Architecture

The app is organised by feature under `lib/features/`, with shared code in `lib/core/`, the HTTP layer in `lib/infrastructure/`, and the generated API package in `packages/analog_api/`.

Before working on the codebase, read [`CONTRIBUTING.md`](CONTRIBUTING.md). It documents the architecture and the conventions every feature follows. Each feature folder also has its own `README.md` describing the caveats specific to that feature.

## Running tests 🧪

```sh
fvm flutter test

make coverage    # with coverage report
```

## Code generation

The HTTP API client in `packages/analog_api/` is generated from `swagger/coffeecard_api_v2.json` with [Tonik](https://pub.dev/packages/tonik) and **is** checked into git.

```sh
make api         # Regenerate from the committed spec
make api-update  # Fetch the latest spec and regenerate (intentional updates)
make api-check   # Verify the committed client is up to date (CI)
```

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the generated-client conventions.

[coverage_badge]: coverage_badge.svg
