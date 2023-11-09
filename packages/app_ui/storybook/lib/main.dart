
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:storybook/stories/component/components.dart';
import 'package:storybook/stories/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const StoryBookApp());
}

class StoryBookApp extends StatelessWidget {
  const StoryBookApp({super.key});
  @override
  Widget build(BuildContext context) => Storybook(
        wrapperBuilder: (context, child) => MaterialApp(
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
          theme: lightTheme,
          darkTheme: darkTheme,
          title: 'Blueprint Storybook',
          home: Scaffold(body: Center(child: child)),
        ),
        stories: [
          ...Components.stories(),
          ...Pages.stories(),
        ],
      );
}