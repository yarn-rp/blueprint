import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';

part 'integrations_cubit.freezed.dart';
part 'integrations_state.dart';

class IntegrationsCubit extends Cubit<IntegrationsState> {
  IntegrationsCubit(this.integrationRepository)
      : super(const IntegrationsState.initial([]));
  final IntegrationsRepository integrationRepository;

  Future<void> getIntegrations() async {
    emit(IntegrationsState.loading(state.integrations));
    try {
      final integrations = await integrationRepository.getIntegrations().first;
      emit(IntegrationsState.loaded(integrations));
    } catch (e) {
      emit(IntegrationsState.error(state.integrations, e.toString()));
    }
  }

  Future<void> addIntegration(Integration integration) async {
    emit(IntegrationsState.loading(state.integrations));
    try {
      await integrationRepository.addIntegration(integration);
      final integrations = await integrationRepository.getIntegrations().first;
      emit(IntegrationsState.loaded(integrations));
    } catch (e) {
      emit(IntegrationsState.error(state.integrations, e.toString()));
    }
  }
}
