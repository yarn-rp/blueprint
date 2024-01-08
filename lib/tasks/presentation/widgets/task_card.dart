import 'package:app_ui/app_ui.dart';
import 'package:blueprint/tasks/presentation/widgets/priority_chip.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    super.key,
    this.onTap,
  });

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return EventCard(
      onTap: onTap,
      labels: [
        LabelChip(
          text: task.project.platformName,
          backgroundColor: HexColor.fromHex(task.project.colorHex),
        ),
        PriorityChip(
          task: task,
        ),
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
