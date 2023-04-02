import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poll_e_task/integrations/entities/integration.dart';
import 'package:poll_e_task/integrations/repositories/integration_repositories.dart';

part 'integrations_cubit.freezed.dart';
part 'integrations_state.dart';

class IntegrationsCubit extends Cubit<IntegrationsState> {
  IntegrationsCubit(this.integrationRepository)
      : super(const IntegrationsState.initial([]));
  final IntegrationRepository integrationRepository;

  Future<void> getIntegrations() async {
    emit(IntegrationsState.loading(state.integrations));
    try {
      final integrations = await integrationRepository.getIntegrations().first;
      emit(IntegrationsState.loaded(integrations));
    } catch (e) {
      emit(IntegrationsState.error(state.integrations, e.toString()));
    }
  }
}
