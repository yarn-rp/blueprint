import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    required this.appointment,
    super.key,
    this.actions = const [],
    this.color,
  });

  final TodayEvent appointment;
  final List<Widget> actions;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final isAfter = appointment.endTime.isAfter(now);
    final originalColor = color ??
        appointment.color ??
        Theme.of(context).colorScheme.tertiaryContainer;

    final startTime =
        Jiffy.parseFromDateTime(appointment.startTime).format(pattern: 'hh:mm');
    final endTime =
        Jiffy.parseFromDateTime(appointment.endTime).format(pattern: 'hh:mm a');

    final title = appointment.subject;
    final subtitle = '$startTime to $endTime';
    final duration = appointment.endTime.difference(appointment.startTime);
    final backgroundColor =
        isAfter ? originalColor : originalColor.withOpacity(0.5);

    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Card(
      margin: EdgeInsets.zero,
      color: backgroundColor,
      child: ListTile(
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: foregroundColor,
              ),
        ),
        subtitle: duration.inMinutes <= 15
            ? null
            : Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: foregroundColor,
                    ),
              ),
      ),
    );
  }
}
