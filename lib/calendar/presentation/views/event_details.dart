import 'package:blueprint/blueprint/entities/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class GeneralEventCalendarEventDetails extends StatelessWidget {
  const GeneralEventCalendarEventDetails({
    required this.appointment,
    required this.onClose,
    this.padding = 32,
    super.key,
  });

  final GeneralCalendarEvent appointment;
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
                        const PopupMenuItem<void>(
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<void>(
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
                  appointment.subject,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                FilledButton.tonalIcon(
                  onPressed: () => launchUrl(Uri.parse('someUrl')),
                  icon: const Icon(Icons.link),
                  label: const Text(
                    'View in ',
                  ),
                )
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
                          child: RichTextBody(
                            text: appointment.event.description ??
                                'No description provided',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),

              // Expanded(
              //   flex: 4,
              //   child: Column(
              //     children: [
              //       Expanded(
              //         flex: 3,
              //         child: Container(
              //           padding: const EdgeInsets.all(16),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color:
              //                   Theme.of(context).dividerColor.withOpacity(0.3),
              //             ),
              //             borderRadius: BorderRadius.circular(4),
              //           ),
              //           child: ListView(
              //             padding: const EdgeInsets.symmetric(horizontal: 16),
              //             children: [
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     'Details',
              //                     style:
              //                         Theme.of(context).textTheme.titleMedium,
              //                   ),
              //                   // Divider
              //                   const Divider(
              //                     endIndent: 0,
              //                     indent: 0,
              //                   ),

              //                   const SizedBox(
              //                     height: 16,
              //                   ),

              //                   Wrap(
              //                     spacing: 8,
              //                     children: [
              //                       ProjectChip(project: task.project),
              //                       ...task.labels
              //                           .map((e) => LabelChip(label: e)),
              //                     ],
              //                   ),
              //                   const SizedBox(
              //                     height: 16,
              //                   ),
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const Text('Time logged'),
              //                       const SizedBox(
              //                         height: 16,
              //                       ),
              //                       // A percentage bar showing the time logged
              //                       if (task.loggedTime != null &&
              //                           task.estimatedTime != null)
              //                         Column(
              //                           children: [
              //                             LinearProgressIndicator(
              //                               value: task.loggedTime!
              //                                       .inMilliseconds /
              //                                   task.estimatedTime!
              //                                       .inMilliseconds,
              //                               valueColor:
              //                                   AlwaysStoppedAnimation<Color>(
              //                                 Theme.of(context)
              //                                     .colorScheme
              //                                     .primary,
              //                               ),
              //                               backgroundColor: Theme.of(context)
              //                                   .colorScheme
              //                                   .primary
              //                                   .withOpacity(
              //                                     0.3,
              //                                   ),
              //                             ),
              //                             const SizedBox(
              //                               height: 8,
              //                             ),
              //                             if (task.loggedTime != null &&
              //                                 task.estimatedTime != null)
              //                               Row(
              //                                 children: [
              //                                   if (task.loggedTime != null)
              //                                     Text(
              //                                       // ignore: lines_longer_than_80_chars
              //                                       '${task.loggedTime!.inHours}h ${task.loggedTime!.inMinutes % 60}m',
              //                                       style: Theme.of(context)
              //                                           .textTheme
              //                                           .bodySmall,
              //                                     ),
              //                                   const Spacer(),
              //                                   if (task.estimatedTime != null)
              //                                     Text(
              //                                       // ignore: lines_longer_than_80_chars
              //                                       '${task.estimatedTime!.inHours}h ${task.estimatedTime!.inMinutes % 60}m',
              //                                       style: Theme.of(context)
              //                                           .textTheme
              //                                           .bodySmall,
              //                                     ),
              //                                 ],
              //                               )
              //                           ],
              //                         ),
              //                     ],
              //                   ),
              //                   // Starting date and due date of the task
              //                   const SizedBox(
              //                     height: 32,
              //                   ),
              //                   Wrap(
              //                     spacing: 16,
              //                     runSpacing: 16,
              //                     children: [
              //                       Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           const Text('Starting date'),
              //                           const SizedBox(
              //                             height: 16,
              //                           ),
              //                           // Use jiffy to format the date
              //                           Text(
              //                             Jiffy(task.startDate)
              //                                 .format('dd MMM yyyy hh:mm a'),
              //                             style: Theme.of(context)
              //                                 .textTheme
              //                                 .bodySmall,
              //                           ),
              //                         ],
              //                       ),
              //                       Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           const Text('Due date'),
              //                           const SizedBox(
              //                             height: 16,
              //                           ),
              //                           Row(
              //                             children: [
              //                               Text(
              //                                 Jiffy(
              //                                   task.dueDate,
              //                                 ).fromNow(),
              //                                 style: Theme.of(context)
              //                                     .textTheme
              //                                     .bodySmall
              //                                     ?.copyWith(
              //                                       color: Theme.of(context)
              //                                           .highlightColor,
              //                                     ),
              //                               ),
              //                               const Text(' - '),
              //                               Expanded(
              //                                 child: Text(
              //                                   Jiffy(task.dueDate).format(
              //                                     'dd MMM yyyy hh:mm a',
              //                                   ),
              //                                   maxLines: 1,
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: Theme.of(context)
              //                                       .textTheme
              //                                       .bodySmall,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),

              //                   // Priority of the task
              //                   const SizedBox(
              //                     height: 32,
              //                   ),
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const Text('Priority'),
              //                       const SizedBox(
              //                         height: 16,
              //                       ),
              //                       PriorityWidget.label(
              //                         priority: task.priority,
              //                       )
              //                     ],
              //                   ),
              //                   const SizedBox(
              //                     height: 16,
              //                   ),
              //                   Wrap(
              //                     runSpacing: 8,
              //                     spacing: 8,
              //                     children: [
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             const Text('Creator'),
              //                             const SizedBox(
              //                               height: 16,
              //                             ),
              //                             UserTile(
              //                               user: task.creator,
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       const SizedBox(
              //                         width: 16,
              //                       ),
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             const Text('Assignees'),
              //                             const SizedBox(
              //                               height: 16,
              //                             ),
              //                             ...task.assigned
              //                                 .map((e) => UserTile(user: e)),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   const SizedBox(
              //                     height: 32,
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 16,
              //       ),
              //       // Updated at and created at of the task
              //       // Use jiffy to format the date
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Align(
              //               alignment: Alignment.centerLeft,
              //               child: Text(
              //                 'Created at ${Jiffy(task.createdAt).format('dd '
              //                     'MMM yyyy hh:mm a')}',
              //                 style: Theme.of(context).textTheme.bodySmall,
              //               ),
              //             ),
              //             const SizedBox(
              //               height: 8,
              //             ),
              //             Align(
              //               alignment: Alignment.centerLeft,
              //               child: Text(
              //                 'Updated at ${Jiffy(task.updatedAt).format('dd '
              //                     'MMM yyyy hh:mm a')}',
              //                 style: Theme.of(context).textTheme.bodySmall,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class RichTextBody extends StatelessWidget {
  const RichTextBody({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final isBasicMD = isBasicMarkdown(text);

    if (!isBasicMD) {
      return Html(
        data: text,
        onLinkTap: (
          url,
          _,
          __,
        ) =>
            launchUrl(Uri.parse(url!)),
      );
    }

    return MarkdownBody(
      selectable: true,
      data: text,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        <md.InlineSyntax>[
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
        ],
      ),
      onTapLink: (String url, String? title, String? id) {
        // Handle link tap
      },
    );
  }
}

bool isBasicMarkdown(String text) {
  // List of HTML tags that are not supported by flutter_markdown
  // This is a simplified list and may not cover all unsupported tags
  final unsupportedTags = <String>[
    '<script',
    '</script>',
    '<style',
    '</style>',
    '<iframe',
    '</iframe>',
    '<object',
    '</object>',
    '<embed',
    '</embed>',
    '<i>',
    '</i>',
    '<a>',
    '</a>',
    // Add more unsupported tags here
  ];

  // Check if the text contains any of the unsupported tags
  for (final tag in unsupportedTags) {
    if (text.contains(tag)) {
      return false;
    }
  }

  return true;
}
