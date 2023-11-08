import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AvatarComponent extends StatelessWidget {
  const AvatarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Avatar',
      child: AvatarIcon(
        text: context.knobs.text(
          label: 'Avatar Name',
          initial: 'YR',
        ),
        backgroundColor: context.knobs.options(
          label: 'Background color',
          initial: Theme.of(context).colorScheme.primary,
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
      ),
    );
  }
}
