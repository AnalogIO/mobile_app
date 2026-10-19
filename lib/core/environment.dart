import 'package:flutter/services.dart';

/// Backend used by the development flavor (`flutter run --flavor development`).
const developmentApiBaseUrl = 'https://core.dev.analogio.dk';

/// Backend used by the production flavor (`flutter run --flavor production`).
///
/// The production app must never point at the development backend. Pointing a
/// release build at the dev database would make every real account appear empty
/// and could write production data into the test environment.
const productionApiBaseUrl = 'https://core.prd.analogio.dk';

/// Optional override for local backend development, e.g.
/// `flutter run --dart-define=API_BASE_URL=http://192.168.1.10:5080`.
///
/// Empty when not provided.
const _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

/// The API base URL for the current build.
String get apiBaseUrl {
  if (_apiBaseUrlOverride.isNotEmpty) {
    return _apiBaseUrlOverride;
  }
  return apiBaseUrlForFlavor(appFlavor);
}

/// Maps a Flutter flavor name to its backend base URL.
///
/// `null`/empty is the flavor used by tests and plain `flutter run` without
/// `--flavor`; it is treated as development so local runs never hit production.
String apiBaseUrlForFlavor(String? flavor) {
  return switch (flavor) {
    'production' => productionApiBaseUrl,
    'development' || null || '' => developmentApiBaseUrl,
    _ => throw StateError('Unknown app flavor: $flavor'),
  };
}
