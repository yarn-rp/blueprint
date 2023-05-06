import 'package:blueprint/settings/entities/working_calendar.dart';

extension DateTimeWeekDays on DateTime {
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
}
