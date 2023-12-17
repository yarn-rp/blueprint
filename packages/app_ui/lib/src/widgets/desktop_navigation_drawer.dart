import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

typedef Destination = ({
  String label,
  IconData icon,
});

class DesktopNavigationBar extends StatefulWidget {
  const DesktopNavigationBar({
    required this.destinations,
    required this.onDestinationSelected,
    this.initialIndex = 0,
    super.key,
  });

  final List<Destination> destinations;
  final ValueChanged<int> onDestinationSelected;
  final int initialIndex;

  @override
  State<DesktopNavigationBar> createState() => _DesktopNavigationBarState();
}

class _DesktopNavigationBarState extends State<DesktopNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.surface,
      child: NavigationDrawer(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          widget.onDestinationSelected(index);
        },
        selectedIndex: _selectedIndex,
        children: [
          const SizedBox(
            height: AppSpacing.lg,
          ),
          ...widget.destinations.map(
            (destination) => NavigationDrawerDestination(
              icon: Icon(destination.icon),
              label: Text(destination.label),
            ),
          ),
        ],
      ),
    );
  }
}
