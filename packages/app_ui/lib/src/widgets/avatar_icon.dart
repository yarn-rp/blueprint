import 'dart:math';

import 'package:flutter/material.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({
    required this.text,
    super.key,
    this.backgroundColor,
  });

  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        this.backgroundColor ?? Theme.of(context).colorScheme.primary;

    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Text(
        text.substring(0, min(text.length, 2)).toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: foregroundColor),
        maxLines: 1,
      ),
    );
  }
}
