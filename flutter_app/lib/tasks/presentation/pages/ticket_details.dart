import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jiffy/jiffy.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:poll_e_task/tasks/entities/entities.dart';
import 'package:poll_e_task/tasks/presentation/widgets/priority_widget.dart';
import 'package:poll_e_task/tasks/presentation/widgets/project_chip.dart';
import 'package:poll_e_task/tasks/presentation/widgets/status_chip.dart';
import 'package:poll_e_task/tasks/presentation/widgets/user_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({
    required this.ticket,
    required this.onClose,
    this.padding = 32,
    super.key,
  });
  final Task ticket;
  final VoidCallback onClose;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          // leading: const SizedBox.shrink(),
          automaticallyImplyLeading: false,
          toolbarHeight: kToolbarHeight + kMinInteractiveDimension + padding,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          leadingWidth: double.infinity,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Row(
                children: [
                  // Options
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          child: Text('Delete'),
                        ),
                      ];
                    },
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            )
          ],
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding)
                .copyWith(top: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () => launchUrl(ticket.ticketURL),
                      icon: const Icon(Icons.add),
                      label: const Text('Add to Today'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FilledButton.tonalIcon(
                      onPressed: () => launchUrl(ticket.ticketURL),
                      icon: const Icon(Icons.link),
                      label: Text(
                        'View in ${ticket.project.platform.displayName}',
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding)
              .copyWith(bottom: padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16)
                      .copyWith(right: 64),
                  children: [
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: MarkdownBody(
                            selectable: true,
                            data: ticket.description,
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
                    const SizedBox(
                      height: 32,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Original estimation'),
                        const SizedBox(
                          height: 16,
                        ),
                        // Use jiffy to format the date
                        Text(
                          ticket.estimatedTime.inHours > 0
                              ? '${ticket.estimatedTime.inHours}h ${ticket.estimatedTime.inMinutes % 60}m'
                              : '${ticket.estimatedTime.inMinutes % 60}m',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                Theme.of(context).dividerColor.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Details',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                // Divider
                                const Divider(
                                  endIndent: 0,
                                  indent: 0,
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                                Row(
                                  children: [
                                    ProjectChip(project: ticket.project),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    TicketStatusChip(ticket: ticket),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
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
                                          value:
                                              ticket.loggedTime.inMilliseconds /
                                                  ticket.estimatedTime
                                                      .inMilliseconds,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${ticket.estimatedTime.inHours}h ${ticket.estimatedTime.inMinutes % 60}m',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                // Starting date and due date of the ticket
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Starting date'),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        // Use jiffy to format the date
                                        Text(
                                          Jiffy(ticket.startDate)
                                              .format('dd MMM yyyy hh:mm a'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Due date'),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              Jiffy(
                                                ticket.dueDate,
                                              ).fromNow(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .highlightColor,
                                                  ),
                                            ),
                                            const Text(' -'),
                                            Text(
                                              Jiffy(ticket.dueDate).format(
                                                'dd MMM yyyy hh:mm a',
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Priority of the ticket
                                const SizedBox(
                                  height: 32,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Priority'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    PriorityWidget.label(
                                      priority: ticket.priority,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Creator'),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          UserTile(
                                            user: ticket.creator,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Assignees'),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ...ticket.assigned
                                              .map((e) => UserTile(user: e)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Updated at and created at of the ticket
                    // Use jiffy to format the date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Created at ${Jiffy(ticket.createdAt).format('dd MMM yyyy hh:mm a')}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Updated at ${Jiffy(ticket.updatedAt).format('dd MMM yyyy hh:mm a')}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
