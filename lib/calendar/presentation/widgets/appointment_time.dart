import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class BlueprintEventTime extends StatelessWidget {
  const BlueprintEventTime({required this.appointment, super.key});

  final BlueprintItem appointment;

  @override
  Widget build(BuildContext context) {
    final startTime = Jiffy.parseFromDateTime(appointment.startTime);
    final endTime = Jiffy.parseFromDateTime(appointment.endTime);
    return Row(
      children: [
        Text(
          startTime.MMMMEEEEd,
        ),
        Text(
          ' : ${startTime.format(pattern: 'h:mm a')} - '
          '${endTime.format(pattern: 'h:mm a')}',
        ),
      ],
    );
  }
}
