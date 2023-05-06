// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'working_calendar.g.dart';

@JsonEnum()
enum DaysOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  // Gets the dateTime of the day of the week. This takes the past day of the
  // week if the day is today or before.
  DateTime get dateTime {
    final now = DateTime.now();
    final day = now.weekday;
    final diff = day - index;
    return now.subtract(Duration(days: diff));
  }
}

@JsonSerializable()
class WorkTime {
  WorkTime({
    required this.start,
    required this.end,
  });

  factory WorkTime.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeFromJson(json);

  factory WorkTime.from9To5() => WorkTime(
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 17, minute: 0),
      );

  @JsonKey(
    fromJson: _timeOfDayFromJson,
    toJson: _timeOfDayToJson,
  )
  final TimeOfDay start;

  @JsonKey(
    fromJson: _timeOfDayFromJson,
    toJson: _timeOfDayToJson,
  )
  final TimeOfDay end;
  Map<String, dynamic> toJson() => _$WorkTimeToJson(this);

  WorkTime copyWith({
    TimeOfDay? start,
    TimeOfDay? end,
  }) {
    return WorkTime(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}

@JsonSerializable()
class WorkingCalendar {
  WorkingCalendar(Map<DaysOfWeek, List<WorkTime>> events)
      : events = {
          ...events,
          for (final day in DaysOfWeek.values)
            if (!events.containsKey(day)) day: [],
        };

  factory WorkingCalendar.fromJson(Map<String, dynamic> json) =>
      _$WorkingCalendarFromJson(json);

  final Map<DaysOfWeek, List<WorkTime>> events;

  Map<String, dynamic> toJson() => _$WorkingCalendarToJson(this);
}

TimeOfDay _timeOfDayFromJson(String time) {
  final parts = time.split(':');
  return TimeOfDay(
    hour: int.parse(parts[0]),
    minute: int.parse(parts[1]),
  );
}

String _timeOfDayToJson(TimeOfDay time) {
  return '${time.hour}:${time.minute}';
}
