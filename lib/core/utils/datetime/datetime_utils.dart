import 'package:blueprint/settings/entities/working_calendar.dart';
import 'package:jiffy/jiffy.dart';

extension DateTimeX on DateTime {
  DaysOfWeek get dayOfWeek {
    switch (weekday) {
      case 1:
        return DaysOfWeek.monday;
      case 2:
        return DaysOfWeek.tuesday;
      case 3:
        return DaysOfWeek.wednesday;
      case 4:
        return DaysOfWeek.thursday;
      case 5:
        return DaysOfWeek.friday;
      case 6:
        return DaysOfWeek.saturday;
      case 7:
        return DaysOfWeek.sunday;
      default:
        throw Exception('Invalid day of week');
    }
  }

  /// Rounds the minutes of the [DateTime] to the nearest [minutes] interval.
  DateTime round({required int minutes}) {
    return copyWith(
        minute:
            minutes * (Jiffy.parseFromDateTime(this).minute / minutes).round());
  }
}
