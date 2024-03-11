extension DateTimeHelper on DateTime {
  DateTime get yesterday {
    return DateTime(
      year,
      month,
      day - 1,
    );
  }

  DateTime get startOfDay {
    return DateTime(
      year,
      month,
      day,
    );
  }

  DateTime get endOfDay {
    return DateTime(
      year,
      month,
      day,
      23,
      59,
      59,
      999,
    );
  }

  bool isBetween(DateTime start, DateTime end) {
    return (isBefore(end) || this == end) && (isAfter(start) || this == start);
  }

  int get daysInMonth {
    return DateTime(
      year,
      month + 1,
      0,
    ).day;
  }
}
