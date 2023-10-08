part of 'integrations_cubit.dart';

@freezed
class IntegrationsState with _$IntegrationsState {
  const factory IntegrationsState.initial(
    Iterable<Platform> availablePlatforms,
    Iterable<Integration> integrations,
  ) = IntegrationsInitial;
  const factory IntegrationsState.loading(
    Iterable<Platform> availablePlatforms,
    Iterable<Integration> integrations,
  ) = IntegrationsLoading;
  const factory IntegrationsState.loaded(
    Iterable<Platform> availablePlatforms,
    Iterable<Integration> integrations,
  ) = IntegrationsLoaded;
  const factory IntegrationsState.error(
    Iterable<Platform> availablePlatforms,
    Iterable<Integration> integrations,
    String message,
  ) = IntegrationsError;
}
