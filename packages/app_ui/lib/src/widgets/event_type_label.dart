import 'package:flutter/material.dart';

class EventTypeLabel extends StatelessWidget {
  factory EventTypeLabel.task({
    Key? key,
  }) {
    // final (foregroundColor, priorityIcon) = switch (priorityLevel) {
    //   // handle cases from 1-5, 1 being the highest priority
    //   1 => (Colors.red, Icons.keyboard_double_arrow_up),
    //   2 => (Colors.orange, Icons.keyboard_arrow_up),
    //   3 => (Colors.yellow, Icons.remove),
    //   4 => (Colors.green, Icons.keyboard_arrow_down),
    //   5 => (Colors.blue, Icons.keyboard_double_arrow_down),
    //   _ => throw ArgumentError.value(
    //       priorityLevel,
    //       'priorityLevel',
    //       'Priority level must be between 1 and 5',
    //     ),
    // };
    return EventTypeLabel._(
      key: key,
      iconData: Icons.task,
    );
  }

  factory EventTypeLabel.calendar({
    Key? key,
  }) =>
      EventTypeLabel._(
        key: key,
        iconData: Icons.calendar_today,
      );
  factory EventTypeLabel.videoConference({
    Key? key,
  }) =>
      EventTypeLabel._(
        key: key,
        iconData: Icons.video_call,
      );

  const EventTypeLabel._({
    required this.iconData,
    super.key,
  });

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.outlineVariant;
    final foregroundColor = theme.colorScheme.onSurfaceVariant;

    return CircleAvatar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: 20,
      child: Icon(
        iconData,
        size: 24,
      ),
    );
  }
}
