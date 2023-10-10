// ignore_for_file: lines_longer_than_80_chars

import 'package:blueprint/calendar/presentation/widgets/appointment_time.dart';
import 'package:blueprint/calendar/presentation/widgets/attendee_tile.dart';
import 'package:blueprint/calendar/presentation/widgets/conference_entrypoints.dart';
import 'package:blueprint/core/utils/color/hex_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:blueprint_repository/blueprint_repository.dart';
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
            ),
          ],
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding)
                .copyWith(top: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Rounded box like google calendar showing event color
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: appointment.event.colorHex != null
                            ? HexColor.fromHex(
                                appointment.event.colorHex!,
                              )
                            : Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      appointment.subject,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                CalendarEventTime(appointment: appointment),
                const SizedBox(
                  height: 8,
                ),
                if (appointment.event.platformLink != null)
                  FilledButton.tonalIcon(
                    onPressed: () => launchUrl(
                      Uri.parse(
                        appointment.event.platformLink!,
                      ),
                    ),
                    icon: const Icon(Icons.link),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'View in ',
                        ),
                        Text(
                          appointment.event.platform.displayName,
                        ),
                      ],
                    ),
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
                          child:
                              EventDetailsDescription(appointment: appointment),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
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
                                if (appointment.event.conferenceData !=
                                    null) ...[
                                  ConferenceEntryPoints(
                                    conferenceData:
                                        appointment.event.conferenceData!,
                                  ),

                                  // Divider
                                  const Divider(
                                    endIndent: 0,
                                    indent: 0,
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                ],
                                CalendarEventTime(appointment: appointment),
                                const SizedBox(
                                  height: 16,
                                ),
                                Wrap(
                                  children: [
                                    if (appointment
                                            .event.attendees?.isNotEmpty ??
                                        false)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Attendees'),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ...appointment
                                              .event.attendees!.entries
                                              .map((attendee) {
                                            final user = attendee.key;
                                            final status = attendee.value;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: AttendeeTile(
                                                platformUrl: null,
                                                attendantStatus: status,
                                                displayName: null,
                                                email: user,
                                              ),
                                            );
                                          }),
                                        ],
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
                    // Updated at and created at of the task
                    // Use jiffy to format the date
                    // Expanded(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           'Created at ${Jiffy(task.createdAt).format('dd '
                    //               'MMM yyyy hh:mm a')}',
                    //           style: Theme.of(context).textTheme.bodySmall,
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 8,
                    //       ),
                    //       Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           'Updated at ${Jiffy(task.updatedAt).format('dd '
                    //               'MMM yyyy hh:mm a')}',
                    //           style: Theme.of(context).textTheme.bodySmall,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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

class EventDetailsDescription extends StatelessWidget {
  const EventDetailsDescription({
    required this.appointment,
    super.key,
  });

  final GeneralCalendarEvent appointment;

  String humanizeEntryPointHeader(String entryPointType) {
    switch (entryPointType) {
      case 'video':
        return 'Video call information';
      case 'phone':
        return 'Phone call';
      case 'sip':
        return 'SIP call';
      case 'more':
        return 'More about phone numbers';
      default:
        return 'Meeting';
    }
  }

  @override
  Widget build(BuildContext context) {
    final descriptionContent = <String>[
      appointment.event.description ?? '',
      appointment.event.conferenceData?.notes ?? '',
    ];

    if (appointment.event.conferenceData?.entryPoints != null) {
      for (final entryPoint in appointment.event.conferenceData!.entryPoints) {
        descriptionContent.add(
          "### ${humanizeEntryPointHeader(entryPoint.entryPointType ?? '')}\n${entryPoint.uri}",
        );
      }
    }

    if (descriptionContent.every((element) => element.isEmpty)) {
      return const Text('No description provided');
    }

    return RichTextBody(
      text: descriptionContent.join('\n'),
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
    if (text.isEmpty) {
      return const SizedBox();
    }

    return MarkdownBody(
      selectable: true,
      data: text,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        <md.InlineSyntax>[
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ],
      ),
      onTapLink: (String url, String? title, String? id) {
        launchUrl(Uri.parse(url));
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
