import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'App Bar',
      maxWidth: 1080,
      child: TopAppBar(
        title: context.knobs.boolean(
          label: 'Show Search bar as title',
          initial: true,
        )
            ? SearchBar(
                trailing: const [
                  Icon(
                    Icons.search,
                  ),
                ],
                hintText: context.knobs.text(
                  label: 'Hint Text',
                  initial: 'Search',
                ),
              )
            : null,
        trailing: AvatarIcon(
          text: context.knobs.text(
            label: 'Avatar Name',
            initial: 'YR',
          ),
        ),
      ),
    );
  }
}
