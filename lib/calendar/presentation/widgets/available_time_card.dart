import 'package:app_ui/app_ui.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AvailableTimeCard extends StatelessWidget {
  const AvailableTimeCard({
    required this.startTime,
    required this.endTime,
    this.onScheduleTime,
    super.key,
  });

  final VoidCallback? onScheduleTime;
  final DateTime startTime;
  final DateTime endTime;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final startTimeJiffy = Jiffy.parseFromDateTime(startTime);
    final endTimeJiffy = Jiffy.parseFromDateTime(endTime);

    return BlueprintEventCard(
      backgroundColor: theme.cardTheme.color,
      actions: [
        FilledButton.icon(
          style: Theme.of(context).filledButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.all(
                  colorScheme.onSurface,
                ),
              ),
          onPressed: onScheduleTime,
          icon: const Icon(
            Icons.add,
            size: 16,
          ),
          label: Text(l10n.addNewTaskCTA),
        ),
      ],
      labels: [
        LabelChip(
          text: l10n.available,
          avatar: const Icon(
            Icons.access_time,
            size: 16,
          ),
        ),
      ],
      dateAndTime: '${startTimeJiffy.jm} - ${endTimeJiffy.jm}',
      title: EventListTile.calendar(
        title: l10n.freeTimeEventTitle,
        subtitle: l10n.freeTimeEventSubtitle,
      ),
    );
  }
}
