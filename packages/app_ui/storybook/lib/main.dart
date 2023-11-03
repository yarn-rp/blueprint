import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const StoryBookApp());
}

class StoryBookApp extends StatelessWidget {
  const StoryBookApp({super.key});
  @override
  Widget build(BuildContext context) => Storybook(
        stories: [
          Story(
            name: 'Screens/TitlePage',
            description: 'Demo Title page that shows a title.',
            builder: (context) => TitlePage(
              title: context.knobs.text(label: 'Title', initial: 'Some title'),
            ),
          ),
        ],
      );
}

class TitlePage extends StatelessWidget {
  const TitlePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(title)),
    );
  }
}
