import 'package:flutter/widgets.dart';
import 'package:storybook/stories/component/app_bar.dart';
import 'package:storybook/stories/component/avatar.dart';
import 'package:storybook/stories/component/buttons.dart';
import 'package:storybook/stories/component/carousel.dart';
import 'package:storybook/stories/component/checkbox.dart';
import 'package:storybook/stories/component/event_card.dart';
import 'package:storybook/stories/component/label_chip.dart';
import 'package:storybook/stories/component/event_type_label.dart';
import 'package:storybook/stories/component/list_tile.dart';
import 'package:storybook/stories/component/navigation_drawer.dart';
import 'package:storybook/stories/component/radio.dart';
import 'package:storybook/stories/component/search_bar.dart';
import 'package:storybook/stories/component/todays_timeline.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const _componentsCategory = 'Components';

typedef ComponentStory = ({
  String name,
  String description,
  Widget widget,
});

class Components {
  static Iterable<Story> stories() => _components.map(
        (story) => Story(
          name: '$_componentsCategory/${story.name}',
          description: story.description,
          builder: (context) => story.widget,
        ),
      );

  static List<ComponentStory> get _components => <ComponentStory>[
        (
          name: 'Navigation Drawer',
          description: 'A navigation drawer for desktop',
          widget: const NavigationDrawerStory()
        ),
        (
          name: 'App Bar',
          description: 'An app bar located at the top of the app',
          widget: const AppBarComponent()
        ),
        (
          name: 'Search',
          description:
              'A bar to search elements on different parts of the the app',
          widget: const SearchBarComponent(),
        ),
        (
          name: 'Buttons',
          description: 'Different types of buttons used in the app',
          widget: const ButtonsComponent(),
        ),
        (
          name: 'Checkbox',
          description: 'Checkbox used in the app',
          widget: const CheckboxComponent(),
        ),
        (
          name: 'Radio',
          description: 'Radio buttons used in the app',
          widget: const RadioComponent(),
        ),
        (
          name: 'Event Type Label',
          description: 'Event type labels used in the app',
          widget: const EventTypeLabelComponent(),
        ),
        (
          name: 'List Tile',
          description: 'List tile used in the app',
          widget: const ListTileComponent(),
        ),
        (
          name: 'Avatar',
          description: 'Avatar used in the app',
          widget: const AvatarComponent(),
        ),
        (
          name: 'Label',
          description: 'Labels used in the app',
          widget: const LabelChipComponent(),
        ),
        (
          name: 'Carousel',
          description: 'Carousel of images used in the app',
          widget: const CarouselComponent(),
        ),
        (
          name: 'Event Card',
          description: 'Event card used in the app',
          widget: const BlueprintEventCardComponent(),
        ),
        (
          name: 'Today Timeline',
          description: 'Timeline in the calendar for today',
          widget: const TodaysTimelineComponent(),
        ),
      ];
}
