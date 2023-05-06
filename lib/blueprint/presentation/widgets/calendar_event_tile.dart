import 'package:blueprint/blueprint/entities/calendar_event.dart';
import 'package:blueprint/blueprint/presentation/widgets/general_calendar_event_tile.dart';
import 'package:blueprint/blueprint/presentation/widgets/task_event_tile.dart';
import 'package:blueprint/tasks/presentation/pages/task_details.dart';
import 'package:flutter/material.dart';

class CalendarEventTile extends StatelessWidget {
  const CalendarEventTile({
    super.key,
    required this.event,
    this.showSmallVersions = false,
  });
  final CalendarEvent event;
  final bool showSmallVersions;

  @override
  Widget build(BuildContext context) {
    return event.map(
      event: (event) => GeneralCalendarEventTile(
        appointment: event,
        isSmallVersion: false,
      ),
      task: (event) => InkWell(
        onTap: () async {
          await showDialog(
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
        child: TaskEventTile(
          appointment: event,
          showDeleteButton: false,
        ),
      ),
    );
  }
}
