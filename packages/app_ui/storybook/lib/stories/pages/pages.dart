import 'package:flutter/widgets.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const _pagesCategory = 'Pages';

typedef PageStory = ({
  String name,
  String description,
  Widget widget,
  List<Component> usedComponents,
});

class Pages {
  static Iterable<Story> stories() => _pages.map(
        (story) => Story(
          name: '$_pagesCategory/${story.name}',
          description: story.description,
          builder: (context) => Column(
            children: [
              // Take all the entire screen for the page and down below a wrap
              // with the used components
              Expanded(
                child: story.widget,
              ),
              Wrap(
                children: story.usedComponents
                    .map(
                      (component) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Component(
                          title: component.title,
                          child: component.child,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );

  static List<PageStory> get _pages => <PageStory>[];
}
