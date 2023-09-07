part of 'integrations_cubit.dart';

@freezed
class IntegrationsState with _$IntegrationsState {
  const factory IntegrationsState.initial(
    Iterable<Integration> integrations,
  ) = IntegrationsInitial;
  const factory IntegrationsState.loading(
    Iterable<Integration> integrations,
  ) = IntegrationsLoading;
  const factory IntegrationsState.loaded(
    Iterable<Integration> integrations,
  ) = IntegrationsLoaded;
  const factory IntegrationsState.error(
    Iterable<Integration> integrations,
    String message,
  ) = IntegrationsError;
}
