import 'package:app_ui/app_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

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
    final originalColor = colorScheme.tertiaryContainer;

    final backgroundColor = originalColor;

    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return BlueprintEventCard(
      onTap: onTap,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      labels: [
        LabelChip(
          avatar: Image.network(event.access.platform!.iconUrl),
          text: event.access.userAccessData.email ??
              event.access.platform!.displayName,
        ),
      ],
      dateAndTime: event.startTime != null && event.endTime != null
          ? '${Jiffy(event.startTime).jm} - ${Jiffy(event.endTime).jm}'
          : null,
      title: event.conferenceData != null
          ? EventListTile.videoConference(
              title: event.subject,
              subtitle: 'Organizer: ${event.organizer?.email ?? ""}',
              textColor: foregroundColor,
            )
          : EventListTile.calendar(
              title: event.subject,
              subtitle: 'Organizer: ${event.organizer?.email ?? ""}',
              textColor: foregroundColor,
            ),
    );
  }
}
