import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.title,
    required this.labels,
    this.dateAndTime,
    this.onTap,
    super.key,
  });

  final EventListTile title;
  final String? dateAndTime;
  final List<LabelChip> labels;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              if (dateAndTime != null)
                SizedBox(
                  height: 44,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          dateAndTime!,
                          style: textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.xlg),
              SizedBox(
                height: AppSpacing.xxxlg,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    spacing: AppSpacing.lg,
                    runSpacing: AppSpacing.lg,
                    children: labels,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
