import 'package:authentication_repository/authentication_repository.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:integrations_repository/integrations_repository.dart';

@module
abstract class BlueprintModule {
  @lazySingleton
  BlueprintBloc blueprintBloc(
    BlueprintRepository blueprintRepository,
  ) =>
      BlueprintBloc(
        blueprintRepository: blueprintRepository,
      );

  @lazySingleton
  BlueprintRepository blueprintRepository(
    FirebaseFirestore firestore,
    IntegrationsRepository integrationsRepository,
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      BlueprintRepository(
        firestore: firestore,
        platformsStream: integrationsRepository.getAllPlatforms(),
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((event) => event?.id),
      );
}
