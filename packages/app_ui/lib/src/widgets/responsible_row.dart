import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ResponsibleRow extends StatelessWidget {
  const ResponsibleRow({
    required this.platformIcon,
    required this.responsible,
    required this.progressColor,
    required this.progress,
    required this.backColorUser,
    super.key,
  });

  final String platformIcon;
  final String responsible;
  final Color progressColor;
  final String progress;
  final Color backColorUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff303030)),
            color: backColorUser,
            borderRadius: BorderRadius.circular(
              AppSpacing.sm,
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: AppSpacing.sm,
                ),
                width: 20,
                height: 20,
                child: Image.network(platformIcon),
              ),
              Text(
                responsible,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff303030)),
            color: progressColor,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: Row(
            children: [
              Text(
                progress,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
