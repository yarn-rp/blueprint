import 'package:flutter/material.dart';
import 'package:poll_e_task/tasks/domain/entities/task.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

class TicketStatusChip extends StatelessWidget {
  const TicketStatusChip({
    super.key,
    required this.ticket,
  });

  final Task ticket;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        ticket.status.status,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      backgroundColor: HexColor.fromHex(ticket.status.hexColor),
    );
  }
}
