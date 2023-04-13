import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:blueprint/blueprint/entities/calendar_event.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/tasks/presentation/widgets/priority_widget.dart';

class TaskEventTile extends StatelessWidget {
  const TaskEventTile({
    super.key,
    required this.appointment,
    this.showDeleteButton = true,
    this.color,
  });
  final TaskCalendarEvent appointment;
  final bool showDeleteButton;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        leading: PriorityWidget(priority: appointment.task.priority),
        isThreeLine: appointment.task.title.length > 50,
        title: Text(
          appointment.task.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDeleteButton)
              IconButton(
                onPressed: () => context
                    .read<TodaysBlueprintCubit>()
                    .removeTaskFromTodaysBlueprint(appointment.task),
                icon: const Icon(Icons.delete),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat('hh:mm a').format(appointment.startTime)} - '
              '${DateFormat('hh:mm a').format(appointment.endTime)}',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            )
          ],
        ),
      ),
    );
  }
}
