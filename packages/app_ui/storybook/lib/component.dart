import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class Component extends StatelessWidget {
  const Component({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560, maxHeight: 560),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xlg),
              width: double.infinity,
              color: Theme.of(context).colorScheme.surfaceTint,
              child: Text(
                title,
                style: textTheme.headlineLarge,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
