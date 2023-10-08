import 'package:blueprint/tasks/presentation/widgets/priority_widget.dart';
import 'package:blueprint/tasks/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    required this.onDetails,
    super.key,
  });
  final Task task;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isPhone = MediaQuery.of(context).size.width < 600;
        final tile = ListTile(
          leading: PriorityWidget(priority: task.priority),
          title: Text(
            task.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: !isPhone
              ? Row(
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
                )
              : null,
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              spacing: 8,
              children: [
                // ProjectChip(project: task.project),
                ...task.labels.map(
                  (e) => LabelChip(label: e),
                ),
              ],
            ),
          ),
        );

        return Card(
          color: Theme.of(context).listTileTheme.tileColor,
          child: InkWell(
            onTap: onDetails,
            child: Padding(
              padding: EdgeInsets.all(!isPhone ? 16 : 4),
              child: tile,
            ),
          ),
        );
      },
    );
  }
}
