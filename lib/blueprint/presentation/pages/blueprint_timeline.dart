import 'package:app_ui/app_ui.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint/calendar/presentation/views/event_details.dart';
import 'package:blueprint/tasks/presentation/widgets/task_details.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlueprintTimeline extends StatelessWidget {
  const BlueprintTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final events = context.select((BlueprintBloc bloc) => bloc.state.items);
    return TodayTimeline(
      onEventTap: (appointment) {
        final event = events.firstWhereOrNull(
          (e) => e.id == appointment.id,
        );

        if (event == null) {
          return;
        }

        return event.map<void>(
          event: (event) => showDialog<void>(
            context: context,
            builder: (context) {
              return Dialog(
                surfaceTintColor: Theme.of(context).canvasColor,
                child: Builder(
                  builder: (context) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1200,
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: EventDetails.dialog(
                        event: event.value,
                        onClose: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          task: (task) => showDialog<void>(
            context: context,
            builder: (context) {
              return Dialog(
                surfaceTintColor: Theme.of(context).canvasColor,
                child: Builder(
                  builder: (context) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1200,
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: TaskDetails.dialog(
                        task: task.value,
                        onClose: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
      events: events.map((e) {
        return (
          id: e.id,
          subject: e.subject,
          startTime: e.startTime,
          endTime: e.endTime,
          color: e.map(
            event: (event) => theme.colorScheme.tertiaryContainer,
            task: (task) => theme.colorScheme.secondaryContainer,
          ),
          isPreview: false,
          type: e.map(
            event: (event) => event.value.conferenceData != null
                ? EventType.meeting
                : EventType.calendar,
            task: (task) => EventType.task,
          ),
        );
      }).toList(),
    );
  }
}
