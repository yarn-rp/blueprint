import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    required this.title,
    required this.child,
    super.key,
  }) : isTitleMini = false;

  const Section.mini({
    required this.title,
    required this.child,
    super.key,
  }) : isTitleMini = true;

  const Section._({
    required this.title,
    required this.child,
    required this.isTitleMini,
  });

  final String title;
  final Widget child;
  final bool isTitleMini;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: isTitleMini ? textTheme.titleMedium : textTheme.titleLarge,
        ),
        const SizedBox(
          height: AppSpacing.lg,
        ),
        child,
      ],
    );
  }
}
