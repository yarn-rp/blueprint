import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

class TimeOfDaySelectorDropdown extends StatelessWidget {
  const TimeOfDaySelectorDropdown({
    required this.onChanged,
    this.value,
    this.minEventDurationInMinutes = 5,
    super.key,
  });

  /// The value of the dropdown
  final TimeOfDay? value;

  /// The minimum duration of an event in minutes
  final int minEventDurationInMinutes;

  /// On changed function
  final ValueChanged<TimeOfDay?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final allDayValues = _allDayTimes(
      Duration(
        minutes: minEventDurationInMinutes,
      ),
    );

    return DropdownButton<TimeOfDay>(
      value: value,
      underline: const SizedBox(),
      selectedItemBuilder: (context) => allDayValues
          .map(
            (time) => Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  time.format(context),
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          )
          .toList(),
      items: [
        ...allDayValues.map((time) {
          return DropdownMenuItem<TimeOfDay>(
            value: time,
            child: Text(
              time.format(context),
              style: theme.textTheme.bodyMedium,
            ),
          );
        }),
      ],
      onChanged: onChanged,
    );
  }
}

/// Returns a list of all the times in a day incremented by [duration]
List<TimeOfDay> _allDayTimes(Duration duration) {
  final now = DateTime.now();

  final startOfDay = DateTime(now.year, now.month, now.day);
  final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

  final times = <TimeOfDay>[];
  for (var time = startOfDay;
      time.isBefore(endOfDay);
      time = time.add(duration)) {
    times.add(TimeOfDay.fromDateTime(time));
  }
  return times;
}
