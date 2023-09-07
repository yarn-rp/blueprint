import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';

part 'available_platforms_cubit.freezed.dart';
part 'available_platforms_state.dart';

class AvailablePlatformsCubit extends Cubit<AvailablePlatformsState> {
  AvailablePlatformsCubit(this.integrationsRepository)
      : super(
          const AvailablePlatformsState.initial(),
        ) {
    integrationsRepository.getAllPlatforms().listen(
          (integrations) => emit(
            AvailablePlatformsState.loaded(integrations),
          ),
        );
  }
  final IntegrationsRepository integrationsRepository;
}
