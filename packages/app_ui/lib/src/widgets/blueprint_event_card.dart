import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class BlueprintEventCard extends StatelessWidget {
  const BlueprintEventCard({
    required this.title,
    required this.labels,
    this.dateAndTime,
    this.onTap,
    super.key,
    this.backgroundColor,
    this.actions = const [],
    this.foregroundColor,
  });

  final EventListTile title;
  final String? dateAndTime;
  final List<LabelChip> labels;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      elevation: 0,
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              if (dateAndTime != null) ...[
                const SizedBox(height: AppSpacing.xlg),
                SizedBox(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: foregroundColor,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          dateAndTime!,
                          style: textTheme.bodyMedium?.copyWith(
                            color: foregroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: AppSpacing.xxxxlg,
                  minHeight: AppSpacing.xxxlg,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: AppSpacing.lg,
                          runSpacing: AppSpacing.lg,
                          children: labels.sublist(
                            0,
                            min(labels.length, 3),
                          ),
                        ),
                      ),
                      if (actions.isNotEmpty) ...[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: actions,
                          ),
                        ),
                      ],
                    ],
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
