import 'package:authentication_repository/authentication_repository.dart';

import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';
import 'package:integrations_repository/integrations_repository.dart';

@module
abstract class IntegrationsModule {
  @lazySingleton
  IntegrationsCubit integrationsCubit(
    IntegrationsRepository integrationsRepository,
  ) =>
      IntegrationsCubit(
        integrationsRepository,
      );

  @lazySingleton
  IntegrationsRepository integrationsRepository(
    FirebaseFirestore firestore,
    FirebaseFunctions functions,
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      IntegrationsRepository(
        firestore: firestore,
        firebaseFunctions: functions,
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((user) => user?.id),
      );
}
