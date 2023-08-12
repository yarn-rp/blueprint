import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:integrations_repository/src/entities/entities.dart';
import 'package:stream_transform/stream_transform.dart';

const _platformsCollectionName = 'platforms';

const _usersCollectionName = 'users';

Task taskFromFirestore(
  DocumentSnapshot<Map<String, dynamic>> snapshot,
  SnapshotOptions? _,
) {
  final data = snapshot.data()!;
  return Task.fromJson(data);
}

Map<String, dynamic> taskToFirestore(Task task, SetOptions? _) => task.toJson();

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    required FirebaseFirestore firestore,
    required FirebaseFunctions firebaseFunctions,
    required this.currentUserIdStream,
  }) {
    _firebaseFunctions = firebaseFunctions;
    _usersCollection = firestore.collection(_usersCollectionName);
    _platformsCollection =
        firestore.collection(_platformsCollectionName).withConverter(
              fromFirestore: (snapshot, _) {
                try {
                  final data = snapshot.data()!;
                  print('data: $data');
                  return Platform.fromJson(data);
                } catch (e) {
                  print('Error parsing platform: $e');
                  rethrow;
                }
              },
              toFirestore: (platform, _) => platform.toJson(),
            );
  }

  /// The platforms collection reference.
  late final CollectionReference<Platform> _platformsCollection;
  late final CollectionReference _usersCollection;

  /// Stream of the current user id.
  final Stream<String?> currentUserIdStream;

  late final FirebaseFunctions _firebaseFunctions;

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<Iterable<Integration>> getAllIntegrations() {
    return Stream.value([]);
  }

  /// Returns a stream of all integrations from all repositories.
  Stream<Iterable<Platform>> getAllPlatforms() {
    print('Fething all platforms');
    final snaps = _platformsCollection.snapshots();
    print('snaps: $snaps');
    return snaps.map((event) => event.docs.map((e) => e.data()));
  }

  /// Returns a stream of all the projects that are linked to the app
  Stream<Iterable<Project>> getAllProjects() {
    return Stream.value([]);
  }

  /// Returns a stream of all tasks that are related to the current user in all
  /// the projects that are linked to the app.
  Stream<Iterable<Task>> getAllTasksRelatedToMe() =>
      currentUserIdStream.switchMap<Iterable<Task>>(
        (userId) {
          print('userId: $userId');
          if (userId == null) {
            return const Stream.empty();
          }
          final userData = _usersCollection.doc(userId);
          // TODO: change this for plans when plan oriented DB is implemented
          final tasksSubCollection =
              userData.collection('tasks').withConverter<Task>(
                    fromFirestore: taskFromFirestore,
                    toFirestore: taskToFirestore,
                  );

          final platformsStream = getAllPlatforms();

          return platformsStream.switchMap(
            (platforms) => tasksSubCollection.snapshots().map(
                  (tasks) => tasks.docs.map((task) {
                    final taskEntity = task.data();
                    final taskPlatform = platforms.firstWhere(
                      (platform) =>
                          platform.displayName ==
                          taskEntity.project.platformName,
                    );
                    return taskEntity.copyWith(
                      project: taskEntity.project.copyWith(
                        platform: taskPlatform,
                      ),
                    );
                  }),
                ),
          );
        },
      );

  /// Adds a new [integration] to the repository.
  Future<void> addIntegration(Integration integration) async {
    try {
      print('Adding integration to firebase functions');

      final callable =
          _firebaseFunctions.httpsCallable('authenticators-connect');
      final params = integration.toConnectApiParams();
      print('params: $params');

      await callable<void>(
        params,
      );
      print('Integration added to firebase functions');
    } on FirebaseFunctionsException catch (exception) {
      print(
        'Error adding integration to firebase functions: ${exception.code} ${exception.message} ${exception.details}',
      );
    } catch (exception) {
      print(exception);
    }
  }

  /// Deletes an [integration] from the repository.
  Future<void> deleteIntegration(Integration integration) async {}

  /// Returns all the tasks that are linked to an specific [project].
  Future<Iterable<Task>> _getProjectTasksRelatedToMe(Project project) {
    // TODO: implement _getProjectTasksRelatedToMe
    return Future.value([]);
  }

  /// Returns all the projects that are under the give repository.
  /// If the integration is not found, because it does not belong to the
  /// repository, it returns an empty list.
  Stream<List<Project>> _getPlatformProjects(
    Platform platform,
  ) {
    return Stream.value([]);
  }

  /// Returns all the projects that are linked to an specific [integration].
  Future<Iterable<Project>> _getProjectsFromIntegration(
    Integration integration,
  ) async {
    return [];
  }
}
