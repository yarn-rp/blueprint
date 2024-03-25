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

    final startTime = Jiffy(appointment.startTime).format('hh:mm');
    final endTime = Jiffy(appointment.endTime).format('hh:mm a');

    final title = appointment.subject;
    final subtitle = '$startTime to $endTime';
    final duration = appointment.endTime.difference(appointment.startTime);
    final backgroundColor =
        isAfter ? originalColor : originalColor.withOpacity(0.5);

    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    final label = switch (appointment.type) {
      EventType.calendar => EventTypeLabel.calendar(),
      EventType.meeting => EventTypeLabel.videoConference(),
      EventType.task => EventTypeLabel.task(),
    };

    return Card(
      margin: EdgeInsets.zero,
      color: backgroundColor,
      child: Column(
        children: [
          EventListTile(
            isMini: duration.inMinutes <= 30,
            leading: label,
            title: title,
            subtitle: subtitle,
            textColor: foregroundColor,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        ],
      ),
    );
  }
}
