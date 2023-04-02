part of 'integrations_cubit.dart';

@freezed
class IntegrationsState with _$IntegrationsState {
  const factory IntegrationsState.initial(
    List<Integration> integrations,
  ) = IntegrationsInitial;
  const factory IntegrationsState.loading(
    List<Integration> integrations,
  ) = IntegrationsLoading;
  const factory IntegrationsState.loaded(
    List<Integration> integrations,
  ) = IntegrationsLoaded;
  const factory IntegrationsState.error(
    List<Integration> integrations,
    String message,
  ) = IntegrationsError;
}
