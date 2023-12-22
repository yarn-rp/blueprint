import 'package:app_ui/src/widgets/list_tile.dart';
import 'package:app_ui/src/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    required this.appointment,
    super.key,
  });

  final TodayEvent appointment;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final isAfter = appointment.endTime.isAfter(now);
    final originalColor =
        appointment.color ?? Theme.of(context).colorScheme.surface;

    final startTime = Jiffy(appointment.startTime).format('hh:mm');
    final endTime = Jiffy(appointment.endTime).format('hh:mm a');

    final title = appointment.subject;
    final subtitle = '$startTime to $endTime';
    final duration = appointment.endTime.difference(appointment.startTime);
    final backgroundColor =
        isAfter ? originalColor : originalColor.withOpacity(0.5);

    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Card(
      margin: EdgeInsets.zero,
      color: isAfter ? originalColor : originalColor.withOpacity(0.5),
      child: EventListTile(
        isMini: duration.inMinutes <= 30,
        leading: appointment.typeLabel,
        title: title,
        subtitle: subtitle,
        textColor: foregroundColor,
      ),
    );
  }
}
