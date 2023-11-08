import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class Component extends StatelessWidget {
  const Component({
    super.key,
    required this.title,
    required this.child,
    this.maxWidth = 560,
    this.maxHeight = 560,
  });

  final String title;
  final Widget child;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final backgroundColor = switch (theme.colorScheme.brightness) {
      Brightness.light => Colors.white,
      Brightness.dark => Colors.black,
    };

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
      child: Card(
        elevation: 0,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(AppSpacing.xlg),
              width: double.infinity,
              child: Text(
                title,
                style: textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xlg),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
