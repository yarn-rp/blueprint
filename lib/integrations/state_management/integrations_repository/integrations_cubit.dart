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
            state.copyWith(
              availablePlatforms: platforms,
            ),
          ),
        );
    integrationRepository.getAuthenticators().listen(
          (authenticators) => emit(
            state.copyWith(
              authenticators: authenticators,
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
        state.authenticators,
      ),
    );

    try {
      await integrationRepository.integrateWithPlatform(
        platformId,
        params,
      );

      emit(
        IntegrationsState.integratedPlatform(
          platformId,
          state.availablePlatforms,
          state.authenticators,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        IntegrationsState.error(
          state.availablePlatforms,
          state.authenticators,
          error.toString(),
        ),
      );
    }
  }

  Future<void> deleteAuthenticator(Authenticator authenticator) async {
    emit(
      IntegrationsState.loading(
        state.availablePlatforms,
        state.authenticators,
      ),
    );

    try {
      await integrationRepository.deleteAuthenticator(authenticator);
    } catch (e) {
      emit(
        IntegrationsState.error(
          state.availablePlatforms,
          state.authenticators,
          e.toString(),
        ),
      );
    }
  }
}
