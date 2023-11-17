import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';

class RadioComponent extends StatelessWidget {
  const RadioComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Radio',
      child: Column(
        children: [
          Radio(
            value: true,
            groupValue: true,
            onChanged: (value) {},
          ),
          Radio(
            value: false,
            groupValue: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
