import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TimeTile extends StatelessWidget {
  const TimeTile({
    required this.time,
    super.key,
  });

  final DateTime? time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: AppSpacing.lg,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(
          width: AppSpacing.sm,
        ),
        Text(
          time != null ? Jiffy(time).format('dd MMM yyyy - hh: mm a') : '-',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
