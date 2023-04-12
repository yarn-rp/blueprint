import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poll_e_task/blueprint/entities/calendar_event.dart';

class CalendarEventTile extends StatelessWidget {
  const CalendarEventTile({super.key, required this.appointment});
  final GeneralCalendarEvent appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onTertiary,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context)
              .colorScheme
              .onTertiaryContainer
              .withOpacity(0.3),
          child: Icon(
            Icons.event,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        title: Text(
          appointment.subject,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat('hh:mm a').format(appointment.startTime)} - '
              '${DateFormat('hh:mm a').format(appointment.endTime)}',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
