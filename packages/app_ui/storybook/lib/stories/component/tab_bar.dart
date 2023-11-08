import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TabBarComponent extends StatelessWidget {
  const TabBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = context.knobs.sliderInt(
      label: 'Amount of tabs',
      initial: 4,
      min: 2,
      max: 20,
    );
    return Component(
      title: 'Tabs',
      child: DefaultTabController(
        length: tabs,
        child: TabBar(
          tabs: List<Tab>.generate(
            tabs,
            (index) => Tab(
              text: context.knobs.text(
                label: 'Tab $index',
                initial: 'Tab $index',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
