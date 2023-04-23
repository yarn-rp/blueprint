// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTime _$WorkTimeFromJson(Map<String, dynamic> json) => WorkTime(
      start: _timeOfDayFromJson(json['start'] as String),
      end: _timeOfDayFromJson(json['end'] as String),
    );

Map<String, dynamic> _$WorkTimeToJson(WorkTime instance) => <String, dynamic>{
      'start': _timeOfDayToJson(instance.start),
      'end': _timeOfDayToJson(instance.end),
    };

WorkingCalendar _$WorkingCalendarFromJson(Map<String, dynamic> json) =>
    WorkingCalendar(
      (json['events'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$DaysOfWeekEnumMap, k),
            (e as List<dynamic>)
                .map((e) => WorkTime.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$WorkingCalendarToJson(WorkingCalendar instance) =>
    <String, dynamic>{
      'events':
          instance.events.map((k, e) => MapEntry(_$DaysOfWeekEnumMap[k]!, e)),
    };

const _$DaysOfWeekEnumMap = {
  DaysOfWeek.monday: 'monday',
  DaysOfWeek.tuesday: 'tuesday',
  DaysOfWeek.wednesday: 'wednesday',
  DaysOfWeek.thursday: 'thursday',
  DaysOfWeek.friday: 'friday',
  DaysOfWeek.saturday: 'saturday',
  DaysOfWeek.sunday: 'sunday',
};
