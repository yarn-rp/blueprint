import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';

part 'integrations_cubit.freezed.dart';
part 'integrations_state.dart';

class IntegrationsCubit extends Cubit<IntegrationsState> {
  IntegrationsCubit(
    this.integrationRepository,
  ) : super(const IntegrationsState.initial([], [])) {
    integrationRepository.getAllPlatforms().listen((data) {
      print('Got platforms: $data');
    });

    integrationRepository.getAllIntegrations().listen((integrations) {
      emit(
        IntegrationsState.loaded(
          integrations,
          state.platforms,
        ),
      );
    });
  }

  final IntegrationsRepository integrationRepository;

  Future<void> addIntegration(Integration integration) async {
    emit(
      IntegrationsState.loading(
        state.integrations,
        state.platforms,
      ),
    );
    try {
      await integrationRepository.addIntegration(integration);
    } catch (e) {
      emit(
        IntegrationsState.error(
          state.integrations,
          state.platforms,
          e.toString(),
        ),
      );
    }
  }

  Future<void> deleteIntegration(Integration integration) async {
    emit(
      IntegrationsState.loading(
        state.integrations,
        state.platforms,
      ),
    );
    try {
      // await integrationRepository.deleteIntegration(integration);
    } catch (e) {
      emit(
        IntegrationsState.error(
          state.integrations,
          state.platforms,
          e.toString(),
        ),
      );
    }
  }
}
