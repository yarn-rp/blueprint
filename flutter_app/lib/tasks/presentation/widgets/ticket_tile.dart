import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poll_e_task/tasks/entities/entities.dart';
import 'package:poll_e_task/tasks/presentation/widgets/priority_widget.dart';
import 'package:poll_e_task/tasks/presentation/widgets/project_chip.dart';
import 'package:poll_e_task/tasks/presentation/widgets/status_chip.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketTile extends StatelessWidget {
  const TicketTile({
    required this.ticket,
    super.key,
    required this.onDetails,
  });
  final Task ticket;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).listTileTheme.tileColor,
      child: InkWell(
        onTap: onDetails,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListTile(
            leading: PriorityWidget(priority: ticket.priority),
            title: Text(ticket.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () => launchUrl(ticket.ticketURL),
                  icon: const Icon(Icons.link),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  ProjectChip(project: ticket.project),
                  const SizedBox(
                    width: 8,
                  ),
                  TicketStatusChip(ticket: ticket),
                  const SizedBox(
                    width: 8,
                  ),
                  Chip(
                    label: Text(
                      'Due date - ${Jiffy(
                        ticket.dueDate,
                      ).fromNow()}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
