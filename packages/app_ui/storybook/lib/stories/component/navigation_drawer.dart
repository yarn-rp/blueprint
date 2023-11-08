import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';

class NavigationDrawerStory extends StatelessWidget {
  const NavigationDrawerStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Navigation Drawer',
      maxHeight: 1200,
      child: SizedBox(
        width: AppSpacing.navigationDrawerMinWidth,
        height: 800,
        child: DesktopNavigationBar(
          onDestinationSelected: (value) {},
          destinations: const [
            (label: 'Home', icon: Icons.home),
            (label: 'Calendar', icon: Icons.calendar_today),
            (label: 'Tasks', icon: Icons.check_circle_outline),
            (label: 'Integrations', icon: Icons.settings)
          ],
        ),
      ),
    );
  }
}
