import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TodaysTimelineComponent extends StatefulWidget {
  const TodaysTimelineComponent({super.key});

  @override
  State<TodaysTimelineComponent> createState() =>
      _TodaysTimelineComponentState();
}

class _TodaysTimelineComponentState extends State<TodaysTimelineComponent> {
  late List<TodayEvent> events;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    events = [
      (
        id: 'test-1',
        subject: context.knobs.text(
          label: 'Event 1',
          initial: 'Meeting with Design team',
        ),
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        color: null,
        type: EventType.meeting,
        isPreview: false,
      ),
      (
        id: 'test-2',
        subject: context.knobs.text(label: 'Event 2', initial: 'Go for a run'),
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        color: Colors.amberAccent,
        type: EventType.calendar,
        isPreview: false,
      ),
      (
        id: 'test-3',
        subject: context.knobs
            .text(label: 'Event 3', initial: 'Implement flutter storybook'),
        startTime: DateTime.now().add(const Duration(hours: 2)),
        endTime: DateTime.now().add(const Duration(hours: 4)),
        color: null,
        type: EventType.task,
        isPreview: false,
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Component(
      maxHeight: size.height,
      maxWidth: size.width,
      title: 'Editable timeline',
      child: SizedBox(
        height: size.height - 200,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: EditableTimeline(
                newEventTemporaryName: 'New event',
                onEventUpdate: (event, startDate, endDate) {
                  final index = events.indexOf(event);

                  setState(() {
                    events[index] = (
                      id: event.id,
                      subject: event.subject,
                      startTime: startDate,
                      endTime: endDate,
                      color: event.color,
                      type: event.type,
                      isPreview: false,
                    );
                  });
                },
                events: events,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
