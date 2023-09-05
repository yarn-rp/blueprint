// ignore_for_file: avoid_dynamic_calls, library_private_types_in_public_api

part of 'todays_blueprint_cubit.dart';

@Freezed(fromJson: true, toJson: true)
abstract class TodaysBlueprintState with _$TodaysBlueprintState {
  const TodaysBlueprintState._();
  const factory TodaysBlueprintState.initial({
    required List<CalendarEvent> calendarEvents,
    required List<WorkTime> workTimes,
    required DateTime addedAt,
  }) = _Initial;
  const factory TodaysBlueprintState.loading({
    required List<CalendarEvent> calendarEvents,
    required List<WorkTime> workTimes,
    required DateTime addedAt,
  }) = _Loading;
  const factory TodaysBlueprintState.loaded({
    required List<CalendarEvent> calendarEvents,
    required List<WorkTime> workTimes,
    required DateTime addedAt,
  }) = _Loaded;
  const factory TodaysBlueprintState.error({
    required String error,
    required List<CalendarEvent> calendarEvents,
    required List<WorkTime> workTimes,
    required DateTime addedAt,
  }) = _Error;

  factory TodaysBlueprintState.fromJson(Map<String, dynamic> json) =>
      _$TodaysBlueprintStateFromJson(json);

  _EventsDataSource get toDataSource => _EventsDataSource([...calendarEvents]);

  CalendarEvent? get currentEvent {
    final now = DateTime.now();
    return calendarEvents.firstWhereOrNull(
      (event) => event.startTime.isBefore(now) && event.endTime.isAfter(now),
    );
  }

  Iterable<CalendarEvent>? get nextEvents {
    final current = currentEvent;

    final endTime = current?.endTime ?? DateTime.now();

    final nextEvents = calendarEvents
        .sorted((a, b) => a.startTime.compareTo(b.startTime))
        .where(
          (event) => event.startTime
              .isAfter(endTime.subtract(const Duration(minutes: 1))),
        );
    return nextEvents;
  }
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
