import 'package:blueprint/integrations/state_management/available_platforms/available_platforms_cubit.dart';
import 'package:blueprint/integrations/state_management/integrations_cubit/integrations_cubit.dart';
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
  AvailablePlatformsCubit availablePlatformsCubit(
    IntegrationsRepository integrationsRepository,
  ) =>
      AvailablePlatformsCubit(
        integrationsRepository,
      );

  @lazySingleton
  IntegrationsRepository integrationsRepository(
    FirebaseFirestore firestore,
    FirebaseFunctions functions,
  ) =>
      IntegrationsRepository(
        firestore: firestore,
        firebaseFunctions: functions,
      );
}
