String timeSince(DateTime time, {DateTime? now}) {
  // Set `now` if not provided
  now ??= DateTime.now();

  final diff = now.difference(time);

  // Future (if more than 1 minute in the future).
  if (diff.isNegative) {
    if (diff <= const Duration(minutes: -1)) return 'In the future';
    return 'Just now';
  }

  // Just now, seconds ago, minutes ago, hours ago.
  if (diff < const Duration(seconds: 1)) return 'Just now';
  if (diff < const Duration(minutes: 1)) {
    return '${_countWithUnit(diff.inSeconds, 'second')} ago';
  }
  if (diff < const Duration(hours: 1)) {
    return '${_countWithUnit(diff.inMinutes, 'minute')} ago';
  }
  if (diff < const Duration(hours: 8)) {
    return '${_countWithUnit(diff.inHours, 'hour')} ago';
  }

  // Earlier today, yesterday, days ago.
  final dayDifference = _calendarDayDifference(from: time, to: now);
  if (dayDifference == 0) return 'Earlier today';
  if (dayDifference == 1) return 'Yesterday';
  if (dayDifference <= 25) return '${_countWithUnit(dayDifference, 'day')} ago';

  // Months ago.
  if (dayDifference <= 345) return _monthsAgo(days: dayDifference);

  // Years ago.
  return _yearsAgo(days: dayDifference);
}

String _monthsAgo({required int days}) {
  final months = days ~/ 30.5;
  final remainder = days % 30.5;

  if (months == 0) {
    return 'around 1 month ago';
  }

  // If remainder is less than 2 days, return x months ago.
  if (remainder < 2) return '${_countWithUnit(months, 'month')} ago';
  // If remainder is more than 28 days, return x+1 months ago.
  if (remainder > 28) {
    return '${_countWithUnit(months + 1, 'month')} ago';
  }

  // If remainder is less than 5 days, return around x months ago.
  if (remainder < 5) {
    return 'around ${_countWithUnit(months, 'month')} ago';
  }
  // If remainder is more than 25 days, return almost x+1 months ago.
  if (remainder > 25) {
    return 'almost ${_countWithUnit(months + 1, 'month')} ago';
  }

  return 'more than ${_countWithUnit(months, 'month')} ago';
}

String _yearsAgo({required int days}) {
  final years = days ~/ 365;
  final remainder = days % 365;

  if (years == 0) {
    return 'almost 1 year ago';
  }

  // If remainder is less than 10 days, return x years ago.
  if (remainder < 10) return '${_countWithUnit(years, 'year')} ago';
  // If remainder is more than 355 days, return x+1 years ago.
  if (remainder > 355) return '${_countWithUnit(years + 1, 'year')} ago';

  // If remainder is less than 20 days, return around x years ago.
  if (remainder < 20) {
    return 'around ${_countWithUnit(years, 'year')} ago';
  }
  // If remainder is more than 345 days, return almost x+1 years ago.
  if (remainder > 345) return 'almost ${_countWithUnit(years + 1, 'year')} ago';

  return 'more than ${_countWithUnit(years, 'year')} ago';
}

String _countWithUnit(int count, String unit) {
  final suffix = count == 1 ? '' : 's';
  return '$count $unit$suffix';
}

int _calendarDayDifference({required DateTime from, required DateTime to}) {
  // Compare date-only values in UTC to avoid DST offsets causing off-by-one
  // results when using local midnights.
  final fromDay = DateTime.utc(from.year, from.month, from.day);
  final toDay = DateTime.utc(to.year, to.month, to.day);
  return toDay.difference(fromDay).inDays;
}
