part of 'integrations_cubit.dart';

@freezed
class IntegrationsState with _$IntegrationsState {
  const factory IntegrationsState.initial(
    Iterable<Integration> integrations,
    Iterable<CalendarIntegration> calendarIntegrations,
    Iterable<CalendarPlatform> calendarPlatforms,
  ) = IntegrationsInitial;
  const factory IntegrationsState.loading(
    Iterable<Integration> integrations,
    Iterable<CalendarIntegration> calendarIntegrations,
    Iterable<CalendarPlatform> calendarPlatforms,
  ) = IntegrationsLoading;
  const factory IntegrationsState.loaded(
    Iterable<Integration> integrations,
    Iterable<CalendarIntegration> calendarIntegrations,
    Iterable<CalendarPlatform> calendarPlatforms,
  ) = IntegrationsLoaded;
  const factory IntegrationsState.error(
    Iterable<Integration> integrations,
    Iterable<CalendarIntegration> calendarIntegrations,
    Iterable<CalendarPlatform> calendarPlatforms,
    String message,
  ) = IntegrationsError;
}
