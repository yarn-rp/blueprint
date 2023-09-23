import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:event_repository/event_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class EventsModule {
  @lazySingleton
  EventRepository taskRepository(
    FirebaseFirestore firestore,
    FirebaseFunctions functions,
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      EventRepository(
        firestore: firestore,
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((user) => user?.id),
      );
}
