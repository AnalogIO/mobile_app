import 'package:equatable/equatable.dart';

/// A period of time with a start and end, expressed as minutes since
/// midnight. For example, 08:00-15:30 becomes `Timeslot(480, 930)`.
class Timeslot extends Equatable {
  const Timeslot(this.startMinute, this.endMinute);

  final int startMinute;
  final int endMinute;

  /// The timeslot in 24-hour format, e.g. `08:00-15:30`.
  String get label => '${_format(startMinute)}-${_format(endMinute)}';

  static String _format(int minute) {
    final hours = (minute ~/ 60).toString().padLeft(2, '0');
    final minutes = (minute % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  List<Object?> get props => [startMinute, endMinute];
}

/// The cafe's regular opening hours, keyed by weekday
/// (`DateTime.monday` .. `DateTime.friday`).
///
/// Weekdays without an entry (weekends) are closed.
///
/// There is no backend endpoint for opening hours, so this is hardcoded —
/// the same static data the old app held in its local data source.
const openingHoursSchedule = <int, Timeslot>{
  DateTime.monday: Timeslot(480, 930), // 08:00-15:30
  DateTime.tuesday: Timeslot(480, 930),
  DateTime.wednesday: Timeslot(480, 930),
  DateTime.thursday: Timeslot(480, 930),
  DateTime.friday: Timeslot(480, 810), // 08:00-13:30
};

/// Plural weekday names keyed by `DateTime.weekday` (1 = Monday).
const weekdayNames = <int, String>{
  DateTime.monday: 'Mondays',
  DateTime.tuesday: 'Tuesdays',
  DateTime.wednesday: 'Wednesdays',
  DateTime.thursday: 'Thursdays',
  DateTime.friday: 'Fridays',
  DateTime.saturday: 'Saturdays',
  DateTime.sunday: 'Sundays',
};

/// The opening hours label for the given weekday (1 = Monday, 7 = Sunday),
/// or `closed` when the cafe is closed that day.
String openingHoursLabel(int weekday) {
  return openingHoursSchedule[weekday]?.label ?? 'closed';
}
