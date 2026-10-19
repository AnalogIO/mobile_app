# Café Analog Coffee Card App

The digital coffee clip card app for Café Analog (the ITU coffee bar). Users buy bundles of tickets with MobilePay, spend a ticket on a drink of their choice and show the receipt as a valid payment.

![coverage][coverage_badge]

## Getting started 🚀

Run `make` (or `make help`) to see all available commands.

```sh
make get        # Install dependencies
make generate   # Generate the API client (see Code generation)
```

Then launch the app from your editor (see Editors below), or:

```sh
flutter run --flavor development   # against the dev backend
flutter run --flavor production    # production app id, name and deep link scheme
```

There are two flavours: `development` and `production`. They differ in application id, display name and deep link scheme.

## Make targets 🛠

| Command                      | What it does                                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------------------------ |
| `make` / `make help`         | Show the help message listing all targets (default target)                                       |
| `make get`                   | Install dependencies (`flutter pub get`)                                                         |
| `make generate` / `make gen` | Regenerate the API client from `swagger/` (`dart run build_runner build`)                        |
| `make swagger`               | Fetch the latest Swagger API specs (`v1`, `v2`) from the backend into `swagger/`                 |
| `make clean`                 | Reset the project: `build_runner clean`, `flutter clean`, then `flutter pub get`                 |
| `make upgrade-flutter`       | Upgrade Flutter/Dart and pin the new versions in `pubspec.yaml` and the CI workflow              |
| `make upgrade-deps`          | Upgrade all dependencies to their latest major versions (`flutter pub upgrade --major-versions`) |
| `make coverage`              | Run `flutter test --coverage` and generate an HTML report in `coverage/html/`                    |
| `make fix`                   | Format code and apply automatic fixes (`dart format .`, `dart fix --apply`)                      |

## Editors 💻

- **VS Code** is the preferred editor. The repository includes workspace configuration in `.vscode/` (launch configurations for the development flavour, recommended extensions for Dart/Flutter and the Bloc extension).
- **IntelliJ / Android Studio** is also supported: the `.run/` directory contains run configurations for the development and production flavours.

## Architecture

The app is organised by feature under `lib/features/`, with shared code in `lib/core/` and the HTTP layer (plus generated API client) in `lib/infrastructure/`.

Before working on the codebase, read [`CONTRIBUTING.md`](CONTRIBUTING.md). It documents the architecture and the conventions every feature follows. Each feature folder also has its own `README.md` describing the caveats specific to that feature.

## Running tests 🧪

```sh
flutter test

make coverage    # with coverage report
```

## Code generation

The HTTP API client in `lib/infrastructure/generated/` is generated from the Swagger specs in `swagger/` and is **not** checked into git.

```sh
make swagger     # Fetch the latest API specs from the backend
make generate    # Regenerate the client (dart run build_runner build)
```

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the quirks of the generated code (especially how API enums are decoded).

[coverage_badge]: coverage_badge.svg
