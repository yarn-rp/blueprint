import 'package:app_ui/app_ui.dart';
import 'package:blueprint/blueprint/presentation/widgets/widgets.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint/calendar/presentation/views/event_details.dart';
import 'package:blueprint/core/utils/datetime/datetime_utils.dart';
import 'package:blueprint/tasks/presentation/widgets/task_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _minEventDurationInMinutes = 5;

class BlueprintTimeline extends StatefulWidget {
  const BlueprintTimeline({super.key});

  @override
  State<BlueprintTimeline> createState() => BlueprintTimelineState();
}

class BlueprintTimelineState extends State<BlueprintTimeline> {
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
          child: TodayTimeline(
            // newEventTemporaryName: l10n.newTaskTitle,
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
            // intervalHeight: 140,
            onEventTap: (event) {
              if (_selectedEvent == event) {
                // User wants to see details of the event
                final item = state.allItems.firstWhere(
                  (element) => element.id == event.id,
                );
                return item.map<void>(
                  event: (event) => showDialog<void>(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        surfaceTintColor: Theme.of(context).canvasColor,
                        child: Builder(
                          builder: (context) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 1200,
                                maxHeight: MediaQuery.of(context).size.height,
                              ),
                              child: EventDetails.dialog(
                                event: event.value,
                                onClose: () => Navigator.of(context).pop(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  task: (task) => showDialog<void>(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        surfaceTintColor: Theme.of(context).canvasColor,
                        child: Builder(
                          builder: (context) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 1200,
                                maxHeight: MediaQuery.of(context).size.height,
                              ),
                              child: TaskDetails.dialog(
                                task: task.value,
                                onClose: () => Navigator.of(context).pop(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
              setState(() {
                _selectedEvent = event;
              });
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
