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
        subject: context.knobs.text(
          label: 'Event 1',
          initial: 'Meeting with Design team',
        ),
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        color: null,
        typeLabel: EventTypeLabel.videoConference(),
      ),
      (
        subject: context.knobs.text(label: 'Event 2', initial: 'Go for a run'),
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        color: Colors.amberAccent,
        typeLabel: EventTypeLabel.calendar(),
      ),
      (
        subject: context.knobs
            .text(label: 'Event 3', initial: 'Implement flutter storybook'),
        startTime: DateTime.now().add(const Duration(hours: 2)),
        endTime: DateTime.now().add(const Duration(hours: 4)),
        color: null,
        typeLabel: EventTypeLabel.task(),
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
      title: 'Todays timeline',
      child: SizedBox(
        height: size.height - 200,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: TodayTimeline(
                onEventUpdate: (event, startDate, endDate) {
                  final index = events.indexOf(event);

                  setState(() {
                    events[index] = (
                      subject: event.subject,
                      startTime: startDate,
                      endTime: endDate,
                      color: event.color,
                      typeLabel: event.typeLabel,
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
