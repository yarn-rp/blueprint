import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poll_e_task/blueprint/entities/calendar_event.dart';

class GeneralCalendarEventTile extends StatelessWidget {
  const GeneralCalendarEventTile({super.key, required this.appointment});
  final GeneralCalendarEvent appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
