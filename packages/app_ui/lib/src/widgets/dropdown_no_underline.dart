import 'package:flutter/material.dart';

class DropdownNoUnderline<T> extends StatelessWidget {
  const DropdownNoUnderline({
    required this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.disabledHint,
    super.key,
  });

  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget? hint;
  final Widget? disabledHint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        iconEnabledColor: Theme.of(context).colorScheme.primary,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        value: 'One',
        onChanged: (value) {},
        items: const [
          DropdownMenuItem(
            value: 'One',
            child: Text('One'),
          ),
          DropdownMenuItem(
            value: 'Two',
            child: Text('Two'),
          ),
          DropdownMenuItem(
            value: 'Three',
            child: Text('Three'),
          ),
        ],
      ),
    );
  }
}
