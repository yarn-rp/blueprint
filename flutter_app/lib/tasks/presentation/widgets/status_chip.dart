import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:poll_e_task/app/styles/styles.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.label,
  });

  final Label label;

  @override
  Widget build(BuildContext context) {
    // Black or white depending on the background color
    final backgroundColor = HexColor.fromHex(label.hexColor);
    final foregroundColor = (backgroundColor?.computeLuminance() ?? 0) > 0.5
        ? Colors.black
        : Colors.white;
    return Chip(
      label: Text(
        label.name,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: foregroundColor,
            ),
      ),
      backgroundColor: backgroundColor == null
          ? backgroundColor
          : Theme.of(context).brightness == Brightness.light
              ? lighten(backgroundColor)
              : darken(backgroundColor),
    );
  }
}
