import 'package:app_ui/app_ui.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint/calendar/presentation/widgets/widgets.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatelessWidget {
  /// Creates a [EventDetails] widget that is displayed as a page.
  factory EventDetails({
    required Event event,
    required VoidCallback onClose,
  }) {
    return EventDetails._(
      event: event,
      onClose: onClose,
      isDialog: false,
    );
  }

  /// Creates a [EventDetails] widget that is displayed as a dialog.
  factory EventDetails.dialog({
    required Event event,
    required VoidCallback onClose,
  }) =>
      EventDetails._(
        event: event,
        onClose: onClose,
        isDialog: true,
      );

  const EventDetails._({
    required this.event,
    required this.onClose,
    required this.isDialog,
  });

  final Event event;
  final VoidCallback onClose;
  final bool isDialog;

  Widget _buildDivider() {
    if (isDialog) {
      return const SizedBox(
        height: AppSpacing.lg,
        width: AppSpacing.lg,
      );
    }

    return const Column(
      children: [
        SizedBox(
          height: AppSpacing.lg,
        ),
        Divider(),
        SizedBox(
          height: AppSpacing.lg,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = isDialog
        ? const EdgeInsets.symmetric(
            horizontal: AppSpacing.xlg,
          )
        : const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          );

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: isDialog
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: theme.dividerTheme.color ?? theme.dividerColor,
              ),
            ),
      margin: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: _EventDetailsAppBar(
          onClose: onClose,
          platformEventUrl: Uri.parse(event.platformLink!),
          platformName: event.access.platform!.displayName,
          eventTitle: event.subject,
        ),
        body: isDialog
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: padding,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                _EventDescriptionSection(
                                  event: event,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: AppSpacing.xlg,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                _EventDetailsSection(
                                  event: event,
                                  isDialog: isDialog,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  _buildDivider(),
                  Padding(
                    padding: padding,
                    child: _EventDescriptionSection(
                      event: event,
                    ),
                  ),
                  _buildDivider(),
                  Padding(
                    padding: padding,
                    child: _EventDetailsSection(
                      event: event,
                      isDialog: isDialog,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _EventDescriptionSection extends StatelessWidget {
  const _EventDescriptionSection({
    required this.event,
  });

  final Event event;

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
    final l10n = context.l10n;

    final descriptionContent = <String>[
      event.description ?? '',
      event.conferenceData?.notes ?? '',
    ];

    if (event.conferenceData?.entryPoints != null) {
      for (final entryPoint in event.conferenceData!.entryPoints) {
        descriptionContent.add(
          "### ${humanizeEntryPointHeader(entryPoint.entryPointType ?? '')}"
          '\n${entryPoint.uri}',
        );
      }
    }
    final description = descriptionContent.join('\n').trim();
    final text =
        description.isNotEmpty ? description : l10n.noDescriptionProvided;

    return Section(
      title: l10n.description,
      child: SizedBox(
        width: double.infinity,
        child: RichTextCard(
          text: text,
        ),
      ),
    );
  }
}

class _EventDetailsSection extends StatelessWidget {
  const _EventDetailsSection({
    required this.event,
    required this.isDialog,
  });

  final Event event;
  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Section(
      title: l10n.details,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event.conferenceData != null) ...[
                  ConferenceEntryPoints(
                    conferenceData: event.conferenceData!,
                  ),
                  const SizedBox(
                    height: AppSpacing.xlg,
                  ),
                ],
                _EventLabels(event: event),
                const SizedBox(
                  height: AppSpacing.xlg,
                ),
                _StartAndEndDates(event: event),
                const SizedBox(
                  height: AppSpacing.xlg,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _EventOrganizer(
                        event: event,
                      ),
                    ),
                    Expanded(
                      child: _EventAttendees(
                        event: event,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSpacing.xlg,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EventOrganizer extends StatelessWidget {
  const _EventOrganizer({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final organizer = event.organizer;

    if (organizer == null) {
      return const SizedBox();
    }

    return Section.mini(
      title: l10n.organizer,
      child: UserTile(
        height: 30,
        platformUrl: organizer.platformUrl,
        avatarUrl: organizer.avatarUrl,
        displayName: organizer.email ?? organizer.displayName ?? ' Unknown',
      ),
    );
  }
}

class _EventAttendees extends StatelessWidget {
  const _EventAttendees({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (event.attendees?.isEmpty ?? true) {
      return const SizedBox();
    }

    return Section.mini(
      title: l10n.attendees,
      child: Wrap(
        children: event.attendees!
            .map(
              (e) => UserTile.customLeading(
                height: 30,
                platformUrl: e.user.platformUrl,
                leading: _AttendantStatusIcon(
                  attendantStatus: e.status,
                ),
                displayName: e.user.email ?? e.user.displayName ?? ' Unknown',
              ),
            )
            .toList(),
      ),
    );
  }
}

class _StartAndEndDates extends StatelessWidget {
  const _StartAndEndDates({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _EventStartTime(
            event: event,
          ),
        ),
        Expanded(
          child: _EventEndTime(
            event: event,
          ),
        ),
      ],
    );
  }
}

class _EventStartTime extends StatelessWidget {
  const _EventStartTime({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Section.mini(
      title: l10n.startTime,
      child: SizedBox(
        width: double.infinity,
        child: TimeTile(
          time: event.startTime,
        ),
      ),
    );
  }
}

class _EventEndTime extends StatelessWidget {
  const _EventEndTime({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Section.mini(
      title: l10n.endTime,
      child: SizedBox(
        width: double.infinity,
        child: TimeTile(
          time: event.endTime,
        ),
      ),
    );
  }
}

class _EventLabels extends StatelessWidget {
  const _EventLabels({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final isEventInTodaysBlueprint = context.select(
      (BlueprintBloc cubit) => cubit.state.items.any(
        (e) => e.map(
          event: (e) => e.value == event,
          task: (e) => false,
        ),
      ),
    );

    return Wrap(
      spacing: 8,
      children: [
        // TODO(yarn-rp): change to platform name
        PlatformChip(event: event),
        if (isEventInTodaysBlueprint) const TodaysBlueprintChip(),
      ],
    );
  }
}

class _EventDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _EventDetailsAppBar({
    required this.onClose,
    required this.platformEventUrl,
    required this.platformName,
    required this.eventTitle,
  });

  final Uri platformEventUrl;
  final String platformName;
  final String eventTitle;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight + kMinInteractiveDimension,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leadingWidth: double.infinity,
      actions: [
        FilledButton.tonalIcon(
          onPressed: () => launchUrl(platformEventUrl),
          icon: const Icon(Icons.link),
          label: Text(
            l10n.viewInPlatformCTA(platformName),
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ],
      title: Text(
        eventTitle,
        style: theme.textTheme.headlineMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight + kMinInteractiveDimension,
      );
}

class _AttendantStatusIcon extends StatelessWidget {
  const _AttendantStatusIcon({
    required this.attendantStatus,
  });

  final AttendantStatus attendantStatus;

  @override
  Widget build(BuildContext context) {
    return switch (attendantStatus) {
      AttendantStatus.accepted => const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        ),
      AttendantStatus.declined => const Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        ),
      AttendantStatus.tentative => const Icon(
          Icons.help,
          color: Colors.orange,
          size: 20,
        ),
      AttendantStatus.needsAction => const Icon(
          Icons.help,
          color: Colors.grey,
          size: 20,
        ),
      AttendantStatus.none => const Icon(
          Icons.help,
          color: Colors.grey,
          size: 20,
        ),
    };
  }
}
