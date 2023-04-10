import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poll_e_task/blueprint/entities/calendar_event.dart';
import 'package:poll_e_task/projects/presentation/widgets/project_chip.dart';
import 'package:poll_e_task/tasks/presentation/widgets/priority_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskEventTile extends StatelessWidget {
  const TaskEventTile({super.key, required this.appointment});
  final TaskCalendarEvent appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        leading: PriorityWidget(priority: appointment.task.priority),
        title: Text(
          appointment.task.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => launchUrl(appointment.task.taskURL),
              icon: const Icon(Icons.link),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectChip(project: appointment.task.project),
            Text(
              '${DateFormat('hh:mm a').format(appointment.startTime)} - '
              '${DateFormat('hh:mm a').format(appointment.endTime)}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
