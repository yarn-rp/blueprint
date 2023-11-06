import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const StoryBookApp());
}

class StoryBookApp extends StatelessWidget {
  const StoryBookApp({super.key});
  @override
  Widget build(BuildContext context) => Storybook(
        wrapperBuilder: (context, child) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            title: 'Blueprint Storybook',
            home: Scaffold(body: Center(child: child)),
          );
        },
        stories: [
          Story(
            name: 'Components/Carousel',
            description: 'A carousel that shows images and titles',
            builder: (context) => Component(
              title: 'Carousel',
              child: SizedBox(
                height: 250,
                width: 400,
                child: Carousel(
                  onImageTap: (index) => print('Image $index tapped'),
                  images: [
                    ...List.generate(
                        context.knobs.sliderInt(
                            initial: 4,
                            label: 'Images',
                            description:
                                'The amount of images to show on the carousel'),
                        (index) {
                      final imageSize = 100 * (index + 1);
                      return (
                        NetworkImage(
                          context.knobs.text(
                              label: 'Image url',
                              initial:
                                  'https://source.unsplash.com/random/$imageSize x $imageSize'),
                        ),
                        context.knobs
                            .text(label: 'Image Text', initial: 'Random Text'),
                      );
                    }),
                  ],
                ),
              ),
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
