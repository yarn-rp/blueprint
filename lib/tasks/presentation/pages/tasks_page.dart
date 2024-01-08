import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/tasks/presentation/widgets/task_card.dart';
import 'package:blueprint/tasks/presentation/widgets/task_details.dart';
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';

@RoutePage()
class TasksPage extends StatefulWidget {
  const TasksPage({
    super.key,
  });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        final tasks = state.tasks;
        final isWide = MediaQuery.of(context).size.width > 1400;

        if (isWide) {
          return _WideTaskPage(tasks: tasks);
        }
        return _NarrowTaskPage(tasks: tasks);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _WideTaskPage extends StatefulWidget {
  const _WideTaskPage({
    required this.tasks,
    super.key,
  });

  final Iterable<Task> tasks;

  @override
  State<_WideTaskPage> createState() => _WideTaskPageState();
}

class _WideTaskPageState extends State<_WideTaskPage> {
  @override
  Widget build(BuildContext context) {
    final selectedTask = context.select(
      (TasksCubit cubit) => cubit.state.selectedTask,
    );

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xlg),
      child: Row(
        children: [
          Expanded(
            child: AnimatedSize(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1200),
              child: ListView(
                children: [
                  ...widget.tasks.map(
                    (task) => TaskCard(
                      task: task,
                      onTap: () => context.read<TasksCubit>().selectTask(task),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xlg),
          if (selectedTask != null)
            Expanded(
              flex: 2,
              child: AnimatedSize(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 1200),
                child: TaskDetails(
                  task: selectedTask,
                  onClose: () => context.read<TasksCubit>().unselectTask(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NarrowTaskPage extends StatelessWidget {
  const _NarrowTaskPage({super.key, required this.tasks});

  final Iterable<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...tasks.map(
          (task) => TaskCard(
            task: task,
            onTap: () async {
              await showDialog<void>(
                context: context,
                builder: (context) {
                  return Dialog(
                    surfaceTintColor: Theme.of(context).canvasColor,
                    child: Builder(
                      builder: (context) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 1200,
                            maxHeight: MediaQuery.of(context).size.height,
                          ),
                          child: TaskDetails(
                            task: task,
                            onClose: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
