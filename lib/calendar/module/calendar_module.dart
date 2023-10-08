import 'package:authentication_repository/authentication_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:injectable/injectable.dart';
import 'package:integrations_repository/integrations_repository.dart';

@module
abstract class CalendarModule {
  @singleton
  CalendarRepository taskRepository(
    FirebaseFirestore firestore,
    FirebaseFunctions functions,
    IntegrationsRepository integrationsRepository,
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      CalendarRepository(
        firestore: firestore,
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((user) => user?.id),
        platformsStream: integrationsRepository.getAllPlatforms(),
      );
}
