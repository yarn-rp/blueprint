import 'package:flutter/material.dart';
import 'package:poll_e_task/tasks/presentation/pages/task_details.dart';
import 'package:poll_e_task/tasks/presentation/widgets/task_tile.dart';
import 'package:project_repository/project_repository.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = <Task>[];
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              padding: const EdgeInsets.all(32),
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
                              surfaceTintColor: Theme.of(context).canvasColor,
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                                child: TaskDetails(
                                  task: task,
                                  onClose: () => Navigator.of(context).pop(),
                                ),
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
  }
}
