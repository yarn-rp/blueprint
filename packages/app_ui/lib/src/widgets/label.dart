import 'package:flutter/material.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    required this.text,
    this.avatar,
    this.backgroundColor,
    super.key,
  });

  final String text;
  final Widget? avatar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = switch (backgroundColor?.computeLuminance()) {
      null => null,
      < 0.5 => Colors.white,
      >= 0.5 => Colors.black,
      _ => null,
    };

    return Chip(
      color: foregroundColor != null
          ? MaterialStateProperty.all(backgroundColor)
          : null,
      label: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: foregroundColor,
            ),
      ),
      avatar: avatar,
    );
  }
}
