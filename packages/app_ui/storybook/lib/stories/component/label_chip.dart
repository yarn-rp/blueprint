import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class LabelChipComponent extends StatelessWidget {
  const LabelChipComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Label',
      child: LabelChip(
        backgroundColor: context.knobs.options(
          label: 'Color',
          initial: null,
          options: [
            Option(
              label: 'Primary Color',
              value: Theme.of(context).colorScheme.primary,
            ),
            const Option(
              label: 'red',
              value: Colors.red,
            ),
            const Option(
              label: 'yellow',
              value: Colors.yellow,
            ),
            const Option(
              label: 'blue',
              value: Colors.blue,
            ),
          ],
        ),
        text: context.knobs.text(label: 'Label name', initial: 'Label'),
        avatar: const Placeholder(),
      ),
    );
  }
}
