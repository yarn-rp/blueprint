import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class BlueprintEventTime extends StatelessWidget {
  const BlueprintEventTime({required this.appointment, super.key});

  final BlueprintItem appointment;

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
