import 'package:authentication_repository/authentication_repository.dart';
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';
import 'package:task_repository/task_repository.dart';

@module
abstract class TaskModule {
  @lazySingleton
  TaskRepository taskRepository(
    FirebaseFirestore firestore,
    FirebaseFunctions functions,
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      TaskRepository(
        firestore: firestore,
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((user) => user?.id),
      );
  @injectable
  TasksCubit taskCubit(TaskRepository taskRepository) => TasksCubit(
        taskRepository,
      );
}
