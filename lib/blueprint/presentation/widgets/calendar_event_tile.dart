import 'package:blueprint/calendar/presentation/views/event_details.dart';
import 'package:blueprint/calendar/presentation/widgets/widgets.dart';
import 'package:blueprint/tasks/presentation/widgets/task_details.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';

class CalendarEventTile extends StatelessWidget {
  const CalendarEventTile({
    required this.event,
    super.key,
    this.showSmallVersions = false,
  });
  final CalendarEvent event;
  final bool showSmallVersions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return event.map(
      event: (event) => EventCard(
        event: event.event,
        onTap: () async {
          await showDialog<void>(
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
                      child: GeneralEventCalendarEventDetails(
                        appointment: event,
                        onClose: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      task: (event) => TaskCard(
        task: event.task,
        backgroundColor: theme.colorScheme.secondaryContainer,
        startTime: event.startTime,
        endTime: event.endTime,
        onTap: () async {
          await showDialog<void>(
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
                      child: TaskDetails(
                        task: event.task,
                        onClose: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
