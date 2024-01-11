import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlueprintEventCard(
      onTap: null,
      backgroundColor: colorScheme.tertiaryContainer,
      actions: [
        FilledButton.icon(
          style: Theme.of(context).filledButtonTheme.style?.copyWith(
                backgroundColor: MaterialStateProperty.all(
                  colorScheme.tertiary,
                ),
              ),
          onPressed: onScheduleTime,
          icon: const Icon(
            Icons.add,
            size: 16,
          ),
          label: const Text('Add New Task'),
        ),
      ],
      labels: const [
        LabelChip(
          text: 'Available',
          avatar: Icon(
            Icons.access_time,
            size: 16,
          ),
        ),
      ],
      dateAndTime: '${Jiffy(startTime).jm} - ${Jiffy(endTime).jm}',
      title: EventListTile.calendar(
        title: 'Free Time',
        subtitle: 'Seems like you have some time to spare. Feel free to enojoy '
            'your free time or schedule a new task for yourself',
      ),
    );
  }
}
