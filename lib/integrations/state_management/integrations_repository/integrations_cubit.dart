import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';

part 'integrations_cubit.freezed.dart';
part 'integrations_state.dart';

class IntegrationsCubit extends Cubit<IntegrationsState> {
  IntegrationsCubit(
    this.integrationRepository,
  ) : super(const IntegrationsState.initial([], [])) {
    integrationRepository.getAllPlatforms().listen(
          (platforms) => emit(
            IntegrationsState.loaded(
              platforms,
              state.integrations,
            ),
          ),
        );
    integrationRepository.getAllIntegrations().listen(
          (integrations) => emit(
            IntegrationsState.loaded(
              state.availablePlatforms,
              integrations,
            ),
          ),
        );
  }
  final IntegrationsRepository integrationRepository;

  /// Integrates with [platformId] using the given [params].
  Future<void> integrateWithPlatform(
    String platformId,
    Map<String, dynamic> params,
  ) async {
    emit(
      IntegrationsState.loading(
        state.availablePlatforms,
        state.integrations,
      ),
    );

    try {
      await integrationRepository.integrateWithPlatform(
        platformId,
        params,
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        IntegrationsState.error(
          state.availablePlatforms,
          state.integrations,
          error.toString(),
        ),
      );
    }
  }

  Future<void> deleteIntegration(Integration integration) async {
    emit(
      IntegrationsState.loading(
        state.availablePlatforms,
        state.integrations,
      ),
    );
    try {
      await integrationRepository.deleteIntegration(integration);
    } catch (e) {
      emit(
        IntegrationsState.error(
          state.availablePlatforms,
          state.integrations,
          e.toString(),
        ),
      );
    }
  }
}
