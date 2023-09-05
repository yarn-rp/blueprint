import 'package:blueprint/blueprint/entities/calendar_event.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class GeneralCalendarEventTile extends StatelessWidget {
  const GeneralCalendarEventTile({
    required this.appointment,
    required this.isSmallVersion,
    super.key,
    this.showDeleteButton = true,
    this.color,
  });
  final GeneralCalendarEvent appointment;

  final bool showDeleteButton;
  final bool isSmallVersion;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    if (isSmallVersion) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                appointment.subject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '${DateFormat('hh:mm a').format(appointment.startTime)} - '
                '${DateFormat('hh:mm a').format(appointment.endTime)}',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              )
            ],
          ),
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.onSecondary.withOpacity(0.3),
          child: Icon(
            Icons.event,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        title: Text(
          appointment.subject,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
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
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
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
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
