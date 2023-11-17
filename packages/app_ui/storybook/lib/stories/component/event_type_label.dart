import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class EventTypeLabelComponent extends StatelessWidget {
  const EventTypeLabelComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Event Type Label',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text('Task'),
              EventTypeLabel.task(
                priorityLevel: context.knobs.sliderInt(
                  label: 'Priority Level',
                  initial: 1,
                  min: 1,
                  max: 5,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text('Calendar'),
              EventTypeLabel.calendar(),
            ],
          ),
          Column(
            children: [
              const Text('Video Conference'),
              EventTypeLabel.videoConference(),
            ],
          ),
        ],
      ),
    );
  }
}
