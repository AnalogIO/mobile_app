import 'package:cafe_analog_app/core/environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('apiBaseUrlForFlavor', () {
    test('uses the development backend for the development flavor', () {
      expect(apiBaseUrlForFlavor('development'), developmentApiBaseUrl);
    });

    test('uses the production backend for the production flavor', () {
      expect(apiBaseUrlForFlavor('production'), productionApiBaseUrl);
    });

    test('falls back to development when no flavor is set', () {
      expect(apiBaseUrlForFlavor(null), developmentApiBaseUrl);
      expect(apiBaseUrlForFlavor(''), developmentApiBaseUrl);
    });

    test('rejects an unknown flavor instead of silently using dev', () {
      expect(() => apiBaseUrlForFlavor('staging'), throwsStateError);
    });
  });
}
