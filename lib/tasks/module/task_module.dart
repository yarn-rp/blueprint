import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:integrations_repository/integrations_repository.dart';

@module
abstract class TaskModule {
  @injectable
  TasksCubit taskCubit(IntegrationsRepository integrationsRepository) =>
      TasksCubit(
        integrationsRepository,
      );
}
