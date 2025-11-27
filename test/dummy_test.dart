import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dummy tests', () {
    test('basic arithmetic works', () {
      expect(2 + 2, equals(4));
    });

    test('string concatenation works', () {
      expect(
        'Hello '
        'World',
        equals('Hello World'),
      );
    });
  });
}
