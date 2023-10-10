import 'package:blueprint/blueprint/entities/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CalendarEventTime extends StatelessWidget {
  const CalendarEventTime({required this.appointment, super.key});

  final CalendarEvent appointment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          Jiffy(appointment.startTime).MMMMEEEEd,
        ),
        Text(
          ' : ${Jiffy(appointment.startTime).format('h:mm a')} - '
          '${Jiffy(appointment.endTime).format('h:mm a')}',
        ),
      ],
    );
  }
}
