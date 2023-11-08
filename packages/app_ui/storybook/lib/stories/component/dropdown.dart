import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';

class DropdownComponent extends StatelessWidget {
  const DropdownComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Dropdown',
      child: DropdownButtonHideUnderline(
        child: DropdownNoUnderline<String>(
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
      ),
    );
  }
}
