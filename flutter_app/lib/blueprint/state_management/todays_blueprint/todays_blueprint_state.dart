part of 'todays_blueprint_cubit.dart';

@Freezed(fromJson: true, toJson: true)
abstract class TodaysBlueprintState with _$TodaysBlueprintState {
  const TodaysBlueprintState._();
  const factory TodaysBlueprintState.initial({
    required List<CalendarEvent> calendarEvents,
    required DateTime addedAt,
  }) = _Initial;
  const factory TodaysBlueprintState.loading({
    required List<CalendarEvent> calendarEvents,
    required DateTime addedAt,
  }) = _Loading;
  const factory TodaysBlueprintState.loaded({
    required List<CalendarEvent> calendarEvents,
    required DateTime addedAt,
  }) = _Loaded;
  const factory TodaysBlueprintState.error({
    required String error,
    required List<CalendarEvent> calendarEvents,
    required DateTime addedAt,
  }) = _Error;

  factory TodaysBlueprintState.fromJson(Map<String, dynamic> json) =>
      _$TodaysBlueprintStateFromJson(json);

  _EventsDataSource get toDataSource => _EventsDataSource([...calendarEvents]);
}

class _EventsDataSource extends CalendarDataSource<CalendarEvent> {
  _EventsDataSource(List<CalendarEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime as DateTime;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay as bool;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime as DateTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject as String;
  }

  @override
  CalendarEvent convertAppointmentToObject(
    CalendarEvent customData,
    Appointment appointment,
  ) {
    return customData.copyWith(
      startTime: appointment.startTime,
      endTime: appointment.endTime,
    );
  }
}
