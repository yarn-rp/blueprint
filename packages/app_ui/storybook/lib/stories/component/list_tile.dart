import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ListTileComponent extends StatelessWidget {
  const ListTileComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
        title: 'ListTiles',
        child: Column(
          children: [
            UserListTile(
              title: context.knobs.text(
                label: 'Title',
                initial: 'List item title',
              ),
              subtitle: context.knobs.text(
                label: 'Subtitle',
                initial: 'List item subtitle',
              ),
              avatarName: context.knobs.text(
                label: 'Avatar',
                initial: 'LE',
              ),
              onTap: () {},
              trailing: FilledButton(
                child: Text(
                  context.knobs.text(
                    label: 'Trailing text',
                    initial: 'Button',
                  ),
                ),
                onPressed: () {},
              ),
            ),
            IntegrationListTile(
              title: context.knobs.text(
                label: 'Title',
                initial: 'List item title',
              ),
              subtitle: context.knobs.text(
                label: 'Subtitle',
                initial: 'List item subtitle',
              ),
              integrationIconUrl: context.knobs.text(
                label: 'Icon url',
                initial: 'https://cdn-icons-png.flaticon.com/512/25/25231.png',
              ),
              trailing: FilledButton(
                child: Text(
                  context.knobs.text(
                    label: 'Trailing text',
                    initial: 'Button',
                  ),
                ),
                onPressed: () {},
              ),
              onTap: () {},
            ),
            EventListTile.videoConference(
              title: context.knobs.text(
                label: 'Title',
                initial: 'List item title',
              ),
              subtitle: context.knobs.text(
                label: 'Subtitle',
                initial: 'List item subtitle',
              ),
              onTap: () {},
              trailing: FilledButton(
                child: Text(
                  context.knobs.text(
                    label: 'Trailing text',
                    initial: 'Button',
                  ),
                ),
                onPressed: () {},
              ),
            ),
            EventListTile.calendar(
              title: context.knobs.text(
                label: 'Title',
                initial: 'List item title',
              ),
              subtitle: context.knobs.text(
                label: 'Subtitle',
                initial: 'List item subtitle',
              ),
              onTap: () {},
              trailing: FilledButton(
                child: Text(
                  context.knobs.text(
                    label: 'Trailing text',
                    initial: 'Button',
                  ),
                ),
                onPressed: () {},
              ),
            ),
            EventListTile.task(
              title: context.knobs.text(
                label: 'Title',
                initial: 'List item title',
              ),
              subtitle: context.knobs.text(
                label: 'Subtitle',
                initial: 'List item subtitle',
              ),
              onTap: () {},
              trailing: FilledButton(
                child: Text(
                  context.knobs.text(
                    label: 'Trailing text',
                    initial: 'Button',
                  ),
                ),
                onPressed: () {},
              ),
            )
          ],
        ));
  }
}
