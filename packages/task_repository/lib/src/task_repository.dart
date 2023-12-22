import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
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
  Stream<Iterable<Task>> getAllTasksRelatedToMe({
    String? query,
    String? platformId,
    SortBy? sortBy,
  }) =>
      _getTasks().map((event) {
        // This is a big tech debt, but for now we will filter the tasks here
        // because it's going to be easier to implement than to do it in the
        // backend.
        var taskList = event.toList();

        if (query != null) {
          taskList = taskList
              .where(
                (task) =>
                    task.title.toLowerCase().contains(query.toLowerCase()) ||
                    task.description.toLowerCase().contains(
                          query.toLowerCase(),
                        ),
              )
              .toList();
        }

        if (platformId != null) {
          taskList = taskList
              .where(
                (task) => task.project.platform?.id == platformId,
              )
              .toList();
        }
        if (sortBy != null) {
          taskList = switch (sortBy.field) {
            (SortField.dueDate) => taskList
              ..sortByCompare(
                (e) => e.dueDate,
                (a, b) {
                  if (a == null && b == null) return 0;
                  if (a == null) return 1;
                  if (b == null) return -1;

                  return a.compareTo(b);
                },
              ),
            (SortField.startDate) => taskList
              ..sortByCompare(
                (e) => e.startDate,
                (a, b) {
                  if (a == null && b == null) return 0;
                  if (a == null) return 1;
                  if (b == null) return -1;

                  return a.compareTo(b);
                },
              ),
            (SortField.priority) => taskList
              ..sortByCompare(
                (e) => e.priority,
                (a, b) => a.compareTo(b),
              ),
            (SortField.title) => taskList
              ..sortByCompare(
                (e) => e.title,
                (a, b) => a.compareTo(b),
              ),
            (SortField.updatedAt) => taskList
              ..sortByCompare(
                (e) => e.updatedAt,
                (a, b) => a.compareTo(b),
              ),
          };

          taskList = sortBy.direction == SortDirection.desc
              ? taskList.reversed.toList()
              : taskList;
        }
        return taskList;
      });

  Stream<Iterable<Task>> _getTasks() =>
      currentUserIdStream.switchMap<Iterable<Task>>(
        (userId) {
          if (userId == null) {
            return const Stream.empty();
          }
          final userData = _usersCollection.doc(userId);
          // TODO(yarn-rp): change this for plans when plan oriented DB is
          // implemented
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
