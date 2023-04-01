import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:poll_e_task/tickets/domain/entities/entities.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

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
              height: 16,
            ),

            // A Badge with the status of the ticket
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${ticket.project.name} - '.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(ticket.status.hexColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ticket.status.status.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
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
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // Divider
                  const Divider(
                    endIndent: 0,
                    indent: 0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Time logged'),
                      const SizedBox(
                        height: 16,
                      ),
                      // A percentage bar showing the time logged
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: ticket.loggedTime.inMilliseconds /
                                ticket.estimatedTime.inMilliseconds,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(
                                  0.3,
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                '${ticket.loggedTime.inHours}h ${ticket.loggedTime.inMinutes % 60}m',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              Text(
                                '${ticket.estimatedTime.inHours}h ${ticket.estimatedTime.inMinutes % 60}m',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
