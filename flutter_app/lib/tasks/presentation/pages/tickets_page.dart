import 'package:flutter/material.dart';
import 'package:poll_e_task/tasks/domain/entities/task.dart';
import 'package:poll_e_task/tasks/presentation/pages/ticket_details.dart';
import 'package:poll_e_task/tasks/presentation/widgets/ticket_tile.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({
    super.key,
    required this.tasks,
  });
  final List<Task> tasks;

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  Task? activeTicket;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onDetails: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              surfaceTintColor: Theme.of(context).canvasColor,
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                                child: TicketDetails(
                                  ticket: ticket,
                                  onClose: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
