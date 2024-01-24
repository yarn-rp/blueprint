import 'package:blueprint/calendar/presentation/views/event_details.dart';
import 'package:blueprint/calendar/presentation/widgets/widgets.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';

class BlueprintItemTile extends StatelessWidget {
  const BlueprintItemTile({
    required this.item,
    super.key,
    this.showSmallVersions = false,
  });
  final BlueprintItem item;
  final bool showSmallVersions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return item.map(
      event: (item) => EventCard(
        event: item.value,
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
                      child: EventDetails.dialog(
                        event: item.value,
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
      task: (item) => TaskCard(
        task: item.value,
        backgroundColor: theme.colorScheme.secondaryContainer,
        startTime: item.startTime,
        endTime: item.endTime,
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
                      child: TaskDetails.dialog(
                        task: item.value,
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
