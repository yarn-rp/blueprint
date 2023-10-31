// ignore_for_file: lines_longer_than_80_chars

import 'package:app_ui/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.taskTitle,
    required this.description,
    required this.startDate,
    required this.priority,
    required this.backgroundColor,
    required this.platformIcon,
    required this.progress,
    required this.progressColor,
    required this.responsible,
    this.isInTodayBlueprint = false,
    super.key,
  });
  final String taskTitle;
  final String description;
  final DateTime startDate;
  final int priority;
  final bool isInTodayBlueprint;
  final Color backgroundColor;
  final String platformIcon;
  final String progress;
  final Color progressColor;
  final String responsible;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: PriorityWidget(priority: priority),
            title: Text(
              taskTitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              '${description.substring(0, 30)}${description.length > 30 ? "..." : ""}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.more_horiz),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: RowCalendar(startDate: startDate),
              ),
              if (isInTodayBlueprint)
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range_outlined),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Today Blueprint',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 10),
            child: ResponsibleRow(
              backColorUser:
                  Theme.of(context).buttonTheme.colorScheme!.background,
              platformIcon: platformIcon,
              responsible: responsible,
              progressColor: progressColor,
              progress: progress,
            ),
          ),
        ],
      ),
    );
  }
}
