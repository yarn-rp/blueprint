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
      >= 0.5 => Colors.black,
      < 0.5 => Colors.white,
      _ => null,
    };

    return Chip(
      color: foregroundColor != null
          ? WidgetStateProperty.all(backgroundColor)
          : null,
      label: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: foregroundColor,
            ),
      ),
      avatar: avatar == null
          ? null
          : Theme(
              data: Theme.of(context).copyWith(
                iconTheme: Theme.of(context).iconTheme.copyWith(
                      color: foregroundColor,
                    ),
              ),
              child: Center(
                child: avatar,
              ),
            ),
    );
  }
}
