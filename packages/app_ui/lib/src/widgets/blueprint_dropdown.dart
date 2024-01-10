import 'package:flutter/material.dart';

Widget _defaultSelectedItemBuilder(
  BuildContext context,
  dynamic item,
  String? hintText,
) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (hintText != null)
        Text(
          hintText,
          style: theme.textTheme.labelSmall,
        ),
      Center(
        child: Text(
          item.toString(),
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    ],
  );
}

class BlueprintDropdown<T> extends StatelessWidget {
  const BlueprintDropdown({
    required this.items,
    this.onChanged,
    this.value,
    super.key,
    this.selectedItemBuilder = _defaultSelectedItemBuilder,
    this.hintText,
  });

  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget Function(
    BuildContext context,
    T item,
    String? hint,
  )? selectedItemBuilder;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton<T>(
      value: value,
      focusColor: Colors.transparent,
      hint: hintText != null
          ? Text(
              hintText!,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            )
          : null,
      underline: const SizedBox(),
      selectedItemBuilder: selectedItemBuilder != null
          ? (context) => items
              .map((e) => selectedItemBuilder!(context, e, hintText))
              .toList()
          : null,
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
