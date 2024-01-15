import 'package:app_ui/app_ui.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlueprintTimeline extends StatelessWidget {
  const BlueprintTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.select((BlueprintBloc bloc) => bloc.state.items);
    return TodayTimeline(
      events: events.map((e) {
        return (
          id: e.id,
          subject: e.subject,
          startTime: e.startTime,
          endTime: e.endTime,
          color: HexColor.fromHex(e.color),
          type: e.map(
            event: (event) => event.event.conferenceData != null
                ? EventType.meeting
                : EventType.calendar,
            task: (task) => EventType.task,
          ),
        );
      }).toList(),
    );
  }
}
