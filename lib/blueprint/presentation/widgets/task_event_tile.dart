import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskEventTile extends StatelessWidget {
  const TaskEventTile({
    required this.appointment,
    super.key,
    this.showDeleteButton = true,
    this.color,
  });
  final TaskCalendarEvent appointment;
  final bool showDeleteButton;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ?? Theme.of(context).colorScheme.secondary;
    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        isThreeLine: true,
        title: Text(
          appointment.task.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: foregroundColor,
              ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDeleteButton)
              IconButton(
                onPressed: () => context
                    .read<TodaysBlueprintCubit>()
                    .removeEvent(appointment),
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: foregroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
