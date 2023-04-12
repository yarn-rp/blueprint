import 'package:flutter/material.dart';
import 'package:poll_e_task/blueprint/entities/calendar_event.dart';
import 'package:poll_e_task/blueprint/presentation/widgets/general_calendar_event_tile.dart';
import 'package:poll_e_task/blueprint/presentation/widgets/task_event_tile.dart';
import 'package:poll_e_task/tasks/presentation/pages/task_details.dart';

class CalendarEventTile extends StatelessWidget {
  const CalendarEventTile({super.key, required this.event});
  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return event.map(
      event: (event) => GeneralCalendarEventTile(appointment: event),
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
