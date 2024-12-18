import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_repository/task_repository.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    this.backgroundColor,
    super.key,
    this.onTap,
    this.startTime,
    this.endTime,
  }) : assert(
          startTime != null && endTime != null ||
              startTime == null && endTime == null,
          'startTime and endTime must be both null or both not null',
        );

  final Task task;
  final DateTime? startTime;
  final DateTime? endTime;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final startTimeJiffy =
        startTime != null ? Jiffy.parseFromDateTime(startTime!) : null;

    final endTimeJiffy =
        endTime != null ? Jiffy.parseFromDateTime(endTime!) : null;

    return BlueprintEventCard(
      onTap: onTap,
      backgroundColor: backgroundColor,
      dateAndTime: startTime != null && endTime != null
          ? '${startTimeJiffy?.jm} - ${endTimeJiffy?.jm}'
          : null,
      labels: const [
        // ProjectPlatformChip(task: task),
        // PriorityChip(task: task),
        // ...task.labels.map(
        //   (e) => LabelChip(
        //     text: e.name,
        //     backgroundColor: HexColor.fromHex(e.colorHex),
        //   ),
        // ),
      ],
      title: EventListTile.task(
        title: task.title,
        subtitle: task.description,
      ),
    );
  }
}
