import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';

class CheckboxComponent extends StatelessWidget {
  const CheckboxComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Checkbox',
      child: Column(
        children: [
          Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          Checkbox(
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
