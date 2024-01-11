import 'package:app_ui/app_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_repository/task_repository.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.event,
    super.key,
    this.onTap,
  });

  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlueprintEventCard(
      onTap: onTap,
      backgroundColor: colorScheme.tertiaryContainer,
      labels: [
        LabelChip(text: event.platform!.displayName),
      ],
      dateAndTime: event.startTime != null && event.endTime != null
          ? '${Jiffy(event.startTime).jm} - ${Jiffy(event.endTime).jm}'
          : null,
      title: event.conferenceData != null
          ? EventListTile.videoConference(
              title: event.subject,
            )
          : EventListTile.calendar(
              title: event.subject,
            ),
    );
  }
}

class IntegrationLabelChip extends LabelChip {
  IntegrationLabelChip({
    required Task task,
    super.key,
  }) : super(
          text: task.project.platformName,
          backgroundColor: null,
          avatar: task.project.platform?.iconUrl != null
              ? Image.network(
                  task.project.platform!.iconUrl,
                  width: 24,
                  height: 24,
                )
              : null,
        );
}
