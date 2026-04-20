import 'package:cafe_analog_app/core/time_since.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final anchor = DateTime(2026, 4, 13, 12);

  group('timeSince', () {
    test('returns in future for times over one minute ahead', () {
      final result = timeSince(
        anchor.add(const Duration(minutes: 2)),
        now: anchor,
      );

      expect(result, 'In the future');
    });

    test('returns just now for times under one minute ahead', () {
      final result = timeSince(
        anchor.add(const Duration(seconds: 30)),
        now: anchor,
      );

      expect(result, 'Just now');
    });

    test('returns just now for times under two seconds ago', () {
      final result = timeSince(
        anchor.subtract(const Duration(seconds: 1)),
        now: anchor,
      );

      expect(result, 'Just now');
    });

    test('returns seconds for times from two seconds ago', () {
      final result = timeSince(
        anchor.subtract(const Duration(seconds: 2)),
        now: anchor,
      );

      expect(result, '2 seconds ago');
    });

    test('uses singular minute/hour grammar', () {
      expect(
        timeSince(anchor.subtract(const Duration(minutes: 1)), now: anchor),
        '1 minute ago',
      );
      expect(
        timeSince(anchor.subtract(const Duration(hours: 1)), now: anchor),
        '1 hour ago',
      );
    });

    test('returns earlier today for same-day events older than 8 hours', () {
      final result = timeSince(
        DateTime(2026, 4, 13, 0, 30),
        now: DateTime(2026, 4, 13, 12),
      );

      expect(result, 'Earlier today');
    });

    test('returns yesterday based on calendar day', () {
      final result = timeSince(
        DateTime(2026, 4, 12, 20, 30),
        now: DateTime(2026, 4, 13, 8, 10),
      );

      expect(result, 'Yesterday');
    });

    test('fixes month/year interpolation grammar', () {
      expect(
        timeSince(anchor.subtract(const Duration(days: 31)), now: anchor),
        '1 month ago',
      );
      expect(
        timeSince(anchor.subtract(const Duration(days: 730)), now: anchor),
        '2 years ago',
      );
    });
  });
}
