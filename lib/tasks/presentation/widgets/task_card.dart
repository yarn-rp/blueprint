import 'package:app_ui/app_ui.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    this.isHighlighted = false,
    super.key,
    this.onTap,
  });

  final Task task;
  final bool isHighlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return EventCard(
      onTap: onTap,
      backgroundColor: isHighlighted ? colorScheme.secondaryContainer : null,
      labels: [
        ProjectPlatformChip(task: task),
        PriorityChip(task: task),
        ...task.labels.map(
          (e) => LabelChip(
            text: e.name,
            backgroundColor: HexColor.fromHex(e.colorHex),
          ),
        ),
      ],
      title: EventListTile.task(
        title: task.title,
        subtitle: task.description,
      ),
    );
  }
}
