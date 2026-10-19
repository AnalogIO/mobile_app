import 'package:cafe_analog_app/features/settings/models/opening_hours.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Timeslot', () {
    test('label formats minutes since midnight in 24-hour format', () {
      expect(const Timeslot(480, 930).label, '08:00-15:30');
      expect(const Timeslot(480, 810).label, '08:00-13:30');
      expect(const Timeslot(0, 60).label, '00:00-01:00');
    });
  });

  group('openingHoursSchedule', () {
    test('contains a shortened Friday and no weekend entries', () {
      expect(openingHoursSchedule[DateTime.friday]?.endMinute, 810);
      expect(openingHoursSchedule.containsKey(DateTime.saturday), isFalse);
      expect(openingHoursSchedule.containsKey(DateTime.sunday), isFalse);
    });
  });

  group('openingHoursLabel', () {
    test('returns hours for open days and closed for others', () {
      expect(openingHoursLabel(DateTime.tuesday), '08:00-15:30');
      expect(openingHoursLabel(DateTime.friday), '08:00-13:30');
      expect(openingHoursLabel(DateTime.saturday), 'closed');
      expect(openingHoursLabel(DateTime.sunday), 'closed');
    });
  });
}
