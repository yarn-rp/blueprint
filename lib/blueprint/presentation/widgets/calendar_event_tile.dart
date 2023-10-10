import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:blueprint/blueprint/presentation/widgets/general_calendar_event_tile.dart';

import 'package:blueprint/blueprint/presentation/widgets/task_event_tile.dart';
import 'package:blueprint/calendar/presentation/views/event_details.dart';
import 'package:blueprint/core/utils/color/hex_color_extension.dart';
import 'package:blueprint/tasks/presentation/pages/task_details.dart';
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
    return event.map(
      event: (event) => InkWell(
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
        child: GeneralCalendarEventTile(
          appointment: event,
          isSmallVersion: false,
          color: event.event.colorHex != null
              ? HexColor.fromHex(
                  event.event.colorHex!,
                )
              : null,
        ),
      ),
      task: (event) => InkWell(
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
        child: TaskEventTile(
          appointment: event,
          showDeleteButton: false,
        ),
      ),
    );
  }
}
