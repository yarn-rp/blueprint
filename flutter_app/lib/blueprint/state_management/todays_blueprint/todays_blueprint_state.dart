part of 'todays_blueprint_cubit.dart';

@freezed
abstract class TodaysBlueprintState with _$TodaysBlueprintState {
  const factory TodaysBlueprintState.initial(
    List<CalendarEvent> calendarEvents,
  ) = _Initial;
  const factory TodaysBlueprintState.loading(
    List<CalendarEvent> calendarEvents,
  ) = _Loading;
  const factory TodaysBlueprintState.loaded(
    List<CalendarEvent> calendarEvents,
  ) = _Loaded;
  const factory TodaysBlueprintState.error(
    String error,
    List<CalendarEvent> calendarEvents,
  ) = _Error;
}
