import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poll_e_task/tasks/domain/entities/entities.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
    required this.tasks,
  });
  final List<TaskEntity> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: tasks
              .map(
                (task) => TaskTile(
                  task: task,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    super.key,
  });
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListTile(
          leading: Checkbox(value: task.isCompleted, onChanged: (v) {}),
          title: Text(task.title),
          subtitle: Row(
            children: [
              // A Badge with the status of the task
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: HexColor.fromHex(task.status.hexColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  task.status.status,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '${task.project.name} - ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                Jiffy(task.dueDate).MMMMEEEEd,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
