import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:task_repository/src/converters/converters.dart';
import 'package:task_repository/src/entities/entities.dart';

const _platformsCollectionName = 'platforms';

const _usersCollectionName = 'users';

/// {@template tasks_repository}
/// Repository in charge of retrieving tasks from user sub-collection in
/// firestore.
/// {@endtemplate}
class TaskRepository {
  /// {@macro tasks_repository}
  TaskRepository({
    required FirebaseFirestore firestore,
    required this.currentUserIdStream,
  }) {
    _usersCollection = firestore.collection(_usersCollectionName);
    _platformsCollection =
        firestore.collection(_platformsCollectionName).withConverter(
              fromFirestore: PlatformConverter.fromFirestore,
              toFirestore: PlatformConverter.toFirestore,
            );
  }

  /// The platforms collection reference.
  late final CollectionReference<Platform> _platformsCollection;
  late final CollectionReference _usersCollection;

  /// Stream of the current user id.
  final Stream<String?> currentUserIdStream;

  /// Returns a stream of all tasks from all repositories.
  Stream<Iterable<Platform>> _getAllPlatforms() {
    final snaps = _platformsCollection.snapshots();
    return snaps.map((event) => event.docs.map((e) => e.data()));
  }

  /// Returns a stream of all tasks that are related to the current user in all
  /// the projects that are linked to the app.
  Stream<Iterable<Task>> getAllTasksRelatedToMe() =>
      currentUserIdStream.switchMap<Iterable<Task>>(
        (userId) {
          if (userId == null) {
            return const Stream.empty();
          }
          final userData = _usersCollection.doc(userId);
          // TODO: change this for plans when plan oriented DB is implemented
          final tasksSubCollection =
              userData.collection('tasks').withConverter<Task>(
                    fromFirestore: TaskConverter.fromFirestore,
                    toFirestore: TaskConverter.toFirestore,
                  );

          final platformsStream = _getAllPlatforms();

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
}
