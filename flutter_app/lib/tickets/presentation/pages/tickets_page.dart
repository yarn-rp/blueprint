import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poll_e_task/tickets/domain/entities/ticket.dart';
import 'package:poll_e_task/tickets/presentation/pages/ticket_details.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({
    super.key,
    required this.tasks,
  });
  final List<Ticket> tasks;

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  Ticket? activeTicket;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
      ),
      body: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              padding: const EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1200),
              child: ListView(
                children: [
                  ...widget.tasks.map(
                    (ticket) => TicketTile(
                      ticket: ticket,
                      onDetails: () => setState(() {
                        if (activeTicket == ticket) {
                          activeTicket = null;
                          return;
                        }
                        activeTicket = ticket;
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedContainer(
            alignment: Alignment.centerRight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 1200),
            height: MediaQuery.of(context).size.height,
            width: activeTicket != null
                ? MediaQuery.of(context).size.width / 4
                : 0,
            child: AnimatedCrossFade(
              alignment: Alignment.centerRight,
              duration: const Duration(milliseconds: 1200),
              sizeCurve: Curves.fastLinearToSlowEaseIn,
              firstCurve: Curves.fastLinearToSlowEaseIn,
              secondCurve: Curves.fastLinearToSlowEaseIn,
              crossFadeState: activeTicket != null
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox(),
              secondChild: activeTicket != null
                  ? TicketDetails(
                      ticket: activeTicket!,
                      onClose: () => setState(() {
                        activeTicket = null;
                      }),
                    )
                  : const SizedBox.shrink(),
            ),
          )
        ],
      ),
    );
  }
}

class TicketTile extends StatelessWidget {
  const TicketTile({
    required this.ticket,
    super.key,
    required this.onDetails,
  });
  final Ticket ticket;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HexColor.fromHex(ticket.project.colorHex)?.withOpacity(0.1),
      child: InkWell(
        onTap: onDetails,
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
      ),
    );
  }
}
