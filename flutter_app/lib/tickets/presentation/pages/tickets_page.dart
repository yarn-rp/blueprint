import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poll_e_task/tickets/domain/entities/ticket.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({
    super.key,
    required this.tasks,
  });
  final List<Ticket> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: tasks
              .map(
                (ticket) => TicketTile(
                  ticket: ticket,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class TicketTile extends StatelessWidget {
  const TicketTile({
    required this.ticket,
    super.key,
  });
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListTile(
          leading: Checkbox(value: ticket.isCompleted, onChanged: (v) {}),
          title: Text(ticket.title),
          subtitle: Row(
            children: [
              // A Badge with the status of the ticket
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: HexColor.fromHex(ticket.status.hexColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  ticket.status.status,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '${ticket.project.name} - ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                Jiffy(ticket.dueDate).MMMMEEEEd,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
