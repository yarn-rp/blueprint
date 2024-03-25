import 'package:flutter/material.dart';

typedef ContextVoidCallback = void Function(BuildContext context);

typedef Action = ({
  String label,
  ContextVoidCallback callback,
  Color? color,
});

Future<T?> showActionDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  List<Action> actions = const [],
}) {
  final width = MediaQuery.sizeOf(context).width;

  return showAdaptiveDialog<T>(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width * 0.5,
        ),
        child: Text(content),
      ),
      actions: actions
          .map(
            (action) => FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(action.color),
              ),
              onPressed: () => action.callback(context),
              child: Text(action.label),
            ),
          )
          .toList(),
    ),
  );
}

Future<void> showErrorDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String dismissText,
}) {
  return showAdaptiveDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(dismissText),
        ),
      ],
    ),
  );
}
