import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:task_repository/src/entities/entities.dart';

const _usersCollectionName = 'users';

/// [Task] converter for firestore
final taskConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return Task.fromJson(data);
  },
  toFirestore: (Task task, SetOptions? options) => task.toJson(),
);

/// {@template task_repository}
/// A repository for managing tasks domain.
/// {@endtemplate}
class TaskRepository {
  /// {@macro task_repository}
  TaskRepository({
    required this.currentUserIdStream,
    required this.platformsStream,
    required FirebaseFirestore firestore,
  }) {
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  /// Stream of the current user id.
  final Stream<String?> currentUserIdStream;

  /// Stream of all supported platforms.
  final Stream<Iterable<Platform>> platformsStream;

  late final CollectionReference _usersCollection;

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
                    fromFirestore: taskConverter.fromFirestore,
                    toFirestore: taskConverter.toFirestore,
                  );

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
