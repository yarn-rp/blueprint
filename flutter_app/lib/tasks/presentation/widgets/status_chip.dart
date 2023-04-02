import 'package:flutter/material.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';
import 'package:project_repository/project_repository.dart';

class TaskStatusChip extends StatelessWidget {
  const TaskStatusChip({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        task.status.status,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      backgroundColor: HexColor.fromHex(task.status.hexColor),
    );
  }
}
