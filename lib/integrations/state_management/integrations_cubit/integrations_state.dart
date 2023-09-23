part of 'integrations_cubit.dart';

@freezed
class IntegrationsState with _$IntegrationsState {
  const factory IntegrationsState.initial(
    Iterable<Integration> integrations,
    Iterable<Platform> platforms,
  ) = IntegrationsInitial;
  const factory IntegrationsState.loading(
    Iterable<Integration> integrations,
    Iterable<Platform> platforms,
  ) = IntegrationsLoading;
  const factory IntegrationsState.loaded(
    Iterable<Integration> integrations,
    Iterable<Platform> platforms,
  ) = IntegrationsLoaded;
  const factory IntegrationsState.error(
    Iterable<Integration> integrations,
    Iterable<Platform> platforms,
    String message,
  ) = IntegrationsError;
}
