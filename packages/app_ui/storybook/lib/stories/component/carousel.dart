import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CarouselComponent extends StatelessWidget {
  const CarouselComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Carousel',
      child: SizedBox(
        height: 250,
        child: Carousel(
          images: [
            ...List.generate(
                context.knobs.sliderInt(
                    initial: 4,
                    label: 'Images',
                    description:
                        'The amount of images to show on the carousel'),
                (index) {
              return (
                NetworkImage(
                  context.knobs.text(
                      label: 'Image url',
                      initial: 'https://source.unsplash.com/random'),
                ),
                context.knobs.text(label: 'Image Text', initial: 'Random Text'),
                () => print('Image $index tapped'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
