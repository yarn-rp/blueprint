import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ButtonsComponent extends StatelessWidget {
  const ButtonsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Buttons',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilledButton(
            onPressed: () {},
            child: Text(
              context.knobs.text(
                label: 'Filled Button Text',
                initial: 'Button',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xlg),
          TextButton(
            onPressed: () {},
            child: Text(
              context.knobs.text(
                label: 'Text Button Text',
                initial: 'Button',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xlg),
          OutlinedButton(
            onPressed: () {},
            child: Text(
              context.knobs.text(
                label: 'Outlined Button Text',
                initial: 'Button',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xlg),
          FilledButton.tonal(
            onPressed: () {},
            child: Text(
              context.knobs.text(
                label: 'Tonal Button Text',
                initial: 'Button',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
