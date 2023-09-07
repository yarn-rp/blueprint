import 'package:authentication_repository/authentication_repository.dart';
import 'package:blueprint/integrations/state_management/available_platforms/available_platforms_cubit.dart';
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:calendar_repository/calendar_repository.dart'
    show CalendarRepository;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:integrations_repository/integrations_repository.dart';

@module
abstract class IntegrationsModule {
  @lazySingleton
  IntegrationsCubit integrationsCubit(
    CalendarRepository integrationsRepository,
    GoogleSignIn googleSignIn,
  ) =>
      IntegrationsCubit(
        integrationsRepository,
        googleSignIn,
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
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      IntegrationsRepository(
        firestore: firestore,
        firebaseFunctions: functions,
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((user) => user?.id),
      );
}
