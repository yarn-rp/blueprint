part of 'integrations_cubit.dart';

@freezed
class IntegrationsState with _$IntegrationsState {
  const factory IntegrationsState.initial(
    Iterable<Platform> availablePlatforms,
    Iterable<Authenticator> authenticators,
  ) = IntegrationsInitial;
  const factory IntegrationsState.loading(
    Iterable<Platform> availablePlatforms,
    Iterable<Authenticator> authenticators,
  ) = IntegrationsLoading;

  const factory IntegrationsState.loaded(
    Iterable<Platform> availablePlatforms,
    Iterable<Authenticator> authenticators,
  ) = IntegrationsLoaded;
  const factory IntegrationsState.integratedPlatform(
    String platformId,
    Iterable<Platform> availablePlatforms,
    Iterable<Authenticator> authenticators,
  ) = IntegratedPlatform;
  const factory IntegrationsState.error(
    Iterable<Platform> availablePlatforms,
    Iterable<Authenticator> authenticators,
    String message,
  ) = IntegrationsError;
}
