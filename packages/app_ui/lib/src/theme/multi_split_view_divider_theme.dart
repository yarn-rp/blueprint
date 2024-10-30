import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

MultiSplitViewTheme buildMultiSplitViewTheme({
  required BuildContext context,
  required Widget child,
}) {
  return MultiSplitViewTheme(
    data: MultiSplitViewThemeData(
      dividerThickness: 4,
      dividerHandleBuffer: 16,
      dividerPainter: DividerPainters.background(
        highlightedColor: Theme.of(context).dividerTheme.color ??
            Theme.of(context).dividerColor,
        color: Colors.transparent,
      ),
    ),
    child: child,
  );
}
