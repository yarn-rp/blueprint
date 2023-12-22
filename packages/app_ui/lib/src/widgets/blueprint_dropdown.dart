import 'package:flutter/material.dart';

Widget _defaultSelectedItemBuilder(BuildContext context, dynamic item) {
  final theme = Theme.of(context);
  return Text(
    item.toString(),
    style: theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.primary,
    ),
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
  final Widget Function(BuildContext context, T item) selectedItemBuilder;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton<T>(
      value: value,
      hint: hintText != null
          ? Text(
              hintText!,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            )
          : null,
      underline: const SizedBox(),
      selectedItemBuilder: (context) =>
          items.map((e) => selectedItemBuilder(context, e)).toList(),
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
