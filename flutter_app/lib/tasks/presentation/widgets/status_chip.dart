import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

class TaskStatusChip extends StatelessWidget {
  const TaskStatusChip({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    // Black or white depending on the background color
    final backgroundColor = HexColor.fromHex(task.status.hexColor);
    final foregroundColor = (backgroundColor?.computeLuminance() ?? 0) > 0.5
        ? Colors.black
        : Colors.white;
    return Chip(
      label: Text(
        task.status.status,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: foregroundColor,
            ),
      ),
      backgroundColor: HexColor.fromHex(task.status.hexColor),
    );
  }
}
