import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/ai_assistant_chat/presentation/pages/ai_assistant.dart';
import 'package:blueprint/ai_assistant_chat/state_management/bloc/ai_assistant_chat_bloc.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/router/app_router.dart';
import 'package:blueprint/blueprint/presentation/widgets/create_event_dialog.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/core/utils/datetime/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

const _minEventDurationInMinutes = 5;

@RoutePage()
class CreateBlueprintPage extends StatelessWidget {
  const CreateBlueprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AiAssistantChatBloc>(
        param1: <String>[
          "Hello! I'm your AI assistant.",
          'I can help you create a blueprint for today.',
        ].reversed.toList(),
      ),
      child: const _CreateBlueprintView(),
    );
  }
}

class _CreateBlueprintView extends StatelessWidget {
  const _CreateBlueprintView();

  void _navigateToTodaysBlueprint(BuildContext context) {
    AutoRouter.of(context).navigate(
      const TodaysBlueprintRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final hasPreviewItems = context.select(
      (BlueprintBloc bloc) => bloc.state.previewItems.isNotEmpty,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            if (!hasPreviewItems) {
              _navigateToTodaysBlueprint(context);
              return;
            }

            final result = await showActionDialog<bool>(
              context: context,
              title: l10n.blueprintPendingChangesDialogTitle,
              content: l10n.blueprintPendingChangesDialogSubtitle,
              actions: [
                (
                  label: l10n.incomingChangesReject,
                  callback: (context) => Navigator.of(context).pop(false),
                  color: theme.colorScheme.error,
                ),
                (
                  label: l10n.incomingChangesAccept,
                  color: theme.colorScheme.primary,
                  callback: (context) => Navigator.of(context).pop(true),
                ),
              ],
            );
            if (!context.mounted || result == null) {
              return;
            }

            if (result) {
              context.read<BlueprintBloc>().add(
                    const PreviewItemsAccepted(),
                  );
            } else {
              context.read<BlueprintBloc>().add(
                    const PreviewsItemsRejected(),
                  );
            }

            _navigateToTodaysBlueprint(context);
          },
        ),
        centerTitle: false,
        backgroundColor: theme.colorScheme.background,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.createTodaysBlueprintTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              l10n.createTodaysBlueprintDescription,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.xxlg),
        child: Portal(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: _Timeline(),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: const _ActionBar(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 4,
                child: AIAssistantChat(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final hasActionItems = context.select(
      (BlueprintBloc bloc) => bloc.state.previewItems.isNotEmpty,
    );

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState:
          hasActionItems ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: const SizedBox.shrink(),
      secondChild: Container(
        color: theme.colorScheme.background.withOpacity(.5),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.incomingChangesTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      theme.colorScheme.error,
                    ),
                  ),
                  onPressed: () => context.read<BlueprintBloc>().add(
                        const PreviewsItemsRejected(),
                      ),
                  child: Text(
                    l10n.incomingChangesReject,
                  ),
                ),
                FilledButton(
                  onPressed: () => context.read<BlueprintBloc>().add(
                        const PreviewItemsAccepted(),
                      ),
                  child: Text(
                    l10n.incomingChangesAccept,
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

class _Timeline extends StatefulWidget {
  const _Timeline();

  @override
  State<_Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<_Timeline> {
  TodayEvent? _selectedEvent;
  TodayEvent? _copiedEvent;

  void _copySelectedEvent() {
    setState(() {
      _copiedEvent = _selectedEvent;
    });
  }

  void _pasteCopiedEvent() {
    if (_copiedEvent != null) {
      final event = context.read<BlueprintBloc>().state.allItems.firstWhere(
            (element) => element.id == _copiedEvent!.id,
          );

      return event.mapOrNull<void>(
        task: (event) => context.read<BlueprintBloc>().add(
              BlueprintTaskItemCreated(
                task: event.value,
                startTime: event.startTime,
                endTime: event.endTime,
              ),
            ),
      );
    }
  }

  void _deleteSelectedEvent() {
    if (_selectedEvent != null) {
      final item = context.read<BlueprintBloc>().state.allItems.firstWhere(
            (element) =>
                element.subject == _selectedEvent!.subject &&
                element.startTime == _selectedEvent!.startTime &&
                element.endTime == _selectedEvent!.endTime,
          );

      item.mapOrNull(
        task: (task) => context.read<BlueprintBloc>().add(
              BlueprintItemDeleted(
                item: item,
              ),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BlueprintBloc, BlueprintState>(
      builder: (context, state) {
        final l10n = context.l10n;

        final items = state.allItems;

        return CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.keyC, control: true):
                _copySelectedEvent,
            const SingleActivator(LogicalKeyboardKey.keyC, meta: true):
                _copySelectedEvent,
            const SingleActivator(LogicalKeyboardKey.keyV, control: true):
                _pasteCopiedEvent,
            const SingleActivator(LogicalKeyboardKey.keyV, meta: true):
                _pasteCopiedEvent,
            const SingleActivator(LogicalKeyboardKey.backspace):
                _deleteSelectedEvent,
          },
          child: EditableTimeline(
            newEventTemporaryName: l10n.newTaskTitle,
            createEventDialogBuilder: (context, event, hidePortal) {
              // Convert the start time to the nearest 15 minute interval
              final roundedStartTime = event.startTime.round(
                minutes: _minEventDurationInMinutes,
              );

              // Convert the end time to the nearest 15 minute interval
              final roundedEndTime = event.endTime.round(
                minutes: _minEventDurationInMinutes,
              );

              return CreateEventDialog(
                hidePortal: hidePortal,
                startTime: roundedStartTime,
                endTime: roundedEndTime,
                onAddTask: (task, startTime, endTime) =>
                    context.read<BlueprintBloc>().add(
                          BlueprintTaskItemCreated(
                            task: task,
                            startTime: startTime,
                            endTime: endTime,
                          ),
                        ),
              );
            },
            intervalHeight: 140,
            onEventTap: (event) {
              setState(() {
                _selectedEvent = event;
              });
            },
            onEventUpdate: (event, startDate, endDate) {
              final item = state.allItems.firstWhere(
                (element) => element.id == event.id,
              );

              return item.map<void>(
                event: (event) {
                  //show error dialog
                  showErrorDialog(
                    context: context,
                    title: 'We are really sorry',
                    content:
                        'We are working on this feature, but unfortunately you '
                        'cannot edit events yet.',
                    dismissText: 'Ok',
                  );
                },
                task: (task) {
                  context.read<BlueprintBloc>().add(
                        BlueprintItemUpdated(
                          item: item,
                          startTime: startDate,
                          endTime: endDate,
                        ),
                      );
                },
              );
            },
            events: [
              ...items.map(
                (e) => (
                  id: e.id,
                  subject: e.subject,
                  startTime: e.startTime,
                  endTime: e.endTime,
                  color: e.isPreview
                      ? theme.colorScheme.primary
                      : e.map(
                          event: (event) => theme.colorScheme.tertiaryContainer,
                          task: (task) => theme.colorScheme.secondaryContainer,
                        ),
                  isPreview: e.isPreview,
                  type: e.map(
                    event: (event) => event.value.conferenceData != null
                        ? EventType.meeting
                        : EventType.calendar,
                    task: (task) => EventType.task,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
