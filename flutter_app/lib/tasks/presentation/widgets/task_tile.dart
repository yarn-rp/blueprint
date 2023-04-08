import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:poll_e_task/projects/presentation/widgets/project_chip.dart';
import 'package:poll_e_task/tasks/presentation/widgets/priority_widget.dart';
import 'package:poll_e_task/tasks/presentation/widgets/status_chip.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    super.key,
    required this.onDetails,
  });
  final Task task;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).listTileTheme.tileColor,
      child: InkWell(
        onTap: onDetails,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListTile(
            leading: PriorityWidget(priority: task.priority),
            title: Text(task.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () => launchUrl(task.taskURL),
                  icon: const Icon(Icons.link),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  ProjectChip(project: task.project),
                  const SizedBox(
                    width: 8,
                  ),
                  TaskStatusChip(task: task),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
