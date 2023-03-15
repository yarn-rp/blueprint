import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:poll_e_task/tickets/domain/entities/entities.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({
    super.key,
    required this.ticket,
    required this.onClose,
  });
  final Ticket ticket;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).listTileTheme.tileColor,
      appBar: AppBar(
        actions: [
          CloseButton(
            onPressed: onClose,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticket.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: MarkdownBody(
                        selectable: true,
                        data: '📝 Task Description : ${ticket.description}',
                        extensionSet: md.ExtensionSet(
                          md.ExtensionSet.commonMark.blockSyntaxes,
                          [
                            md.EmojiSyntax(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
