import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_e_task/tasks/presentation/pages/task_details.dart';
import 'package:poll_e_task/tasks/presentation/widgets/task_tile.dart';
import 'package:poll_e_task/tasks/state_management/cubit/tasks_cubit.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    super.key,
  });

  @override
  State<TasksPage> createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    context.read<TasksCubit>().loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        final tasks = state.tasks;
        final isPhone = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          body: Row(
            children: [
              Expanded(
                child: AnimatedContainer(
                  padding: EdgeInsets.all(isPhone ? 4 : 32),
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1200),
                  child: ListView(
                    children: [
                      ...tasks.map(
                        (task) => TaskTile(
                          task: task,
                          onDetails: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  surfaceTintColor:
                                      Theme.of(context).canvasColor,
                                  child: Builder(
                                    builder: (context) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: 1200,
                                          maxHeight: MediaQuery.of(context)
                                              .size
                                              .height,
                                        ),
                                        child: TaskDetails(
                                          task: task,
                                          onClose: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
