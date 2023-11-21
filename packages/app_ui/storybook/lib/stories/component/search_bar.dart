import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class SearchBarComponent extends StatelessWidget {
  const SearchBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Component(
      title: 'Search',
      child: SearchBar(
        trailing: const [
          Icon(
            Icons.search,
          ),
        ],
        hintText: context.knobs.text(
          label: 'Hint Text',
          initial: 'Search',
        ),
      ),
    );
  }
}
