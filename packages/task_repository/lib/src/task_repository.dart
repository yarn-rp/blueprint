import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_repository/src/entities/entities.dart';

const _usersCollectionName = 'users';
const _tasksCollectionName = 'tasks';

final blueprintPlatform = PlatformData(
  id: 'blueprint',
  displayName: 'Blueprint',
  iconUrl: 'assets/icons/blueprint.svg',
);

class BlueprintPlatformAccess extends Access {
  BlueprintPlatformAccess._({
    required String email,
    required String gid,
    required String name,
  }) : super(
          platformId: blueprintPlatform.id,
          userAccessData: UserAccessData(email: email, gid: gid, name: name),
        );

  factory BlueprintPlatformAccess.fromBlueprintUser(Map<String, dynamic> map) {
    return BlueprintPlatformAccess._(
      email: map['email'] as String,
      gid: '',
      name: map['displayName'] as String? ?? map['email'] as String,
    );
  }
}

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
    required Stream<String?> currentUserIdStream,
    required this.platformsStream,
    required FirebaseFirestore firestore,
  }) {
    _usersCollection = firestore.collection(_usersCollectionName);
    _allUserTasks = BehaviorSubject<Iterable<Task>>();
    _currentUserIdStream = BehaviorSubject<String>();
    currentUserIdStream.listen(_currentUserIdStream.add);
  }

  /// Stream of all supported platforms.
  final Stream<Iterable<Platform>> platformsStream;

  /// The collection of users.
  late final CollectionReference _usersCollection;

  /// The current user id.
  late final BehaviorSubject<String?> _currentUserIdStream;

  /// The tasks
  late final BehaviorSubject<Iterable<Task>> _allUserTasks;

  /// The subscription to the tasks
  // ignore: cancel_subscriptions
  StreamSubscription<Iterable<Task>>? _tasksSubscription;

  static String platformId = 'blueprint';

  Future<void> deleteTask(Task task) {
    final userId = _currentUserIdStream.value;

    if (userId == null) {
      throw Exception('User not logged in');
    }

    final userRef = _usersCollection.doc(userId);
    final tasksSubCollection =
        userRef.collection(_tasksCollectionName).withConverter<Task>(
              fromFirestore: taskConverter.fromFirestore,
              toFirestore: taskConverter.toFirestore,
            );

    return tasksSubCollection.doc(task.id).delete();
  }

  Future<void> createBlueprintTask({
    required String title,
    required String description,
    DateTime? dueDate,
    Duration? estimatedTime,
    Iterable<Label> labels = const [],
    int priority = 3,
  }) async {
    try {
      log('Creating task: $title');
      final userId = _currentUserIdStream.value;

      if (userId == null) {
        throw Exception('User not logged in');
      }

      final userRef = _usersCollection.doc(userId);
      final userData = await userRef
          .get()
          .then((value) => value.data()! as Map<String, dynamic>);

      final creator = User(
        userData['email'] as String,
        userData['email'] as String,
        userData['photoURL'] as String? ?? '',
      );

      final tasksSubCollection =
          userRef.collection(_tasksCollectionName).withConverter<Task>(
                fromFirestore: taskConverter.fromFirestore,
                toFirestore: taskConverter.toFirestore,
              );
      final taskRef = tasksSubCollection.doc();

      final task = Task(
        id: taskRef.id,
        access: BlueprintPlatformAccess.fromBlueprintUser(userData),
        title: title,
        description: description,
        startDate: DateTime.now(),
        dueDate: dueDate,
        estimatedTime: estimatedTime,
        labels: labels,
        priority: priority,
        creator: creator,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        taskURL: Uri.parse('https://blueprint.com/task/${taskRef.id}'),
        assigned: [creator],
        loggedTime: null,
        isCompleted: false,
      );

      await taskRef.set(task);
      log('Task created: ${taskRef.id}');
    } catch (error, stackTrace) {
      log('Error creating task: $error at $stackTrace');

      rethrow;
    }
  }

  Stream<Iterable<Task>> _getAllTasksRelatedToMe() {
    if (_tasksSubscription != null) {
      return _allUserTasks.stream;
    }

    _tasksSubscription = _currentUserIdStream.switchMap<Iterable<Task>>(
      (userId) {
        if (userId == null) {
          return const Stream.empty();
        }
        final userData = _usersCollection.doc(userId);
        // TODO(yarn-rp): change this for plans when plan oriented DB is
        // implemented
        final tasksSubCollection =
            userData.collection(_tasksCollectionName).withConverter<Task>(
                  fromFirestore: taskConverter.fromFirestore,
                  toFirestore: taskConverter.toFirestore,
                );

        return platformsStream.switchMap(
          (platforms) => tasksSubCollection.snapshots().map(
                (tasks) => tasks.docs.map((task) {
                  final taskEntity = task.data();

                  final taskPlatform = platforms.firstWhere(
                    (platform) => platform.id == taskEntity.access.platformId,
                    orElse: () {
                      if (taskEntity.access.platformId ==
                          blueprintPlatform.id) {
                        return Platform(
                          id: blueprintPlatform.id,
                          displayName: blueprintPlatform.displayName,
                          iconUrl: blueprintPlatform.iconUrl,
                          authentication: const NoAuthentication(),
                        );
                      }
                      throw Exception('Platform not found');
                    },
                  );

                  return taskEntity.copyWith(
                    access: taskEntity.access.withPlatform(taskPlatform),
                  );
                }),
              ),
        );
      },
    ).listen((tasks) {
      _allUserTasks.add(tasks);
    });

    return _allUserTasks.stream;
  }

  /// Returns a stream of all tasks that are related to the current user in all
  /// the projects that are linked to the app.
  Stream<Iterable<Task>> getTasks({
    String? query,
    String? platformId,
    SortBy? sortBy,
  }) =>
      _getAllTasksRelatedToMe().map((event) {
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
                (task) => task.access.platformId == platformId,
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
}
