// ignore_for_file: lines_longer_than_80_chars

import 'package:app_ui/app_ui.dart';
import 'package:blueprint/calendar/presentation/widgets/appointment_time.dart';
import 'package:blueprint/calendar/presentation/widgets/attendee_tile.dart';
import 'package:blueprint/calendar/presentation/widgets/conference_entrypoints.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralEventBlueprintEventDetails extends StatelessWidget {
  const GeneralEventBlueprintEventDetails({
    required this.appointment,
    required this.onClose,
    this.padding = 32,
    super.key,
  });

  final EventBlueprintItem appointment;
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
                        color: appointment.value.colorHex != null
                            ? HexColor.fromHex(
                                appointment.value.colorHex,
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
                BlueprintEventTime(appointment: appointment),
                const SizedBox(
                  height: 8,
                ),
                if (appointment.value.platformLink != null)
                  FilledButton.tonalIcon(
                    onPressed: () => launchUrl(
                      Uri.parse(
                        appointment.value.platformLink!,
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
                          appointment.value.platform?.displayName ?? '',
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
                                if (appointment.value.conferenceData !=
                                    null) ...[
                                  ConferenceEntryPoints(
                                    conferenceData:
                                        appointment.value.conferenceData!,
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
                                BlueprintEventTime(appointment: appointment),
                                const SizedBox(
                                  height: 16,
                                ),
                                Wrap(
                                  children: [
                                    if (appointment
                                            .value.attendees?.isNotEmpty ??
                                        false)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Attendees'),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ...appointment.value.attendees!
                                              .map((attendee) {
                                            final user = attendee.user;
                                            final status = attendee.status;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: AttendeeTile(
                                                platformUrl: null,
                                                attendantStatus: status,
                                                displayName: null,
                                                email: user.email,
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

  final EventBlueprintItem appointment;

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
      appointment.value.description ?? '',
      appointment.value.conferenceData?.notes ?? '',
    ];

    if (appointment.value.conferenceData?.entryPoints != null) {
      for (final entryPoint in appointment.value.conferenceData!.entryPoints) {
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
