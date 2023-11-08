import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
    this.trailing,
    this.title,
  });

  final Widget? trailing;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppSpacing.appBarHeight,
      leadingWidth: AppSpacing.logoWidth,
      leading: const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Align(
          alignment: Alignment.centerLeft,
          child: BlueprintLogo(),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: title,
      ),
      actions: [
        if (trailing != null) trailing!,
        const SizedBox(width: AppSpacing.md),
      ],
    );
  }
}
