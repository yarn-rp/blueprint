import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class BlockDialog extends StatelessWidget {
  const BlockDialog({
    required this.title,
    required this.btnText,
    required this.content,
    required this.onPressed,
    super.key,
  });
  final String title;
  final String content;
  final String btnText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Container(
        width: size.width * 0.3,
        padding: const EdgeInsets.all(AppSpacing.xxlg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              size: AppSpacing.xxxlg,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              content,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: onPressed,
              child: Text(btnText),
            ),
          ],
        ),
      ),
    );
  }
}
