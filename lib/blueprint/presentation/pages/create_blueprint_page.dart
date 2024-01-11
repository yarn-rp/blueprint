import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
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
    return const _CreateBlueprintView();
  }
}

class _CreateBlueprintView extends StatelessWidget {
  const _CreateBlueprintView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            AutoRouter.of(context).navigate(
              const TodaysBlueprintRoute(),
            );
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
      body: const Padding(
        padding: EdgeInsets.only(left: AppSpacing.xxlg),
        child: Portal(
          child: _Timeline(),
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
      final event = context.read<BlueprintBloc>().state.items.firstWhere(
            (element) => element.id == _copiedEvent!.id,
          );

      return event.map<void>(
        task: (event) => context.read<BlueprintBloc>().add(
              CalendarEventCreated(
                task: event.task,
                startTime: event.startTime,
                endTime: event.endTime,
              ),
            ),
        event: (event) => showGeneralDialog(
          context: context,
          pageBuilder: (context, _, __) {
            return Text('Error, events cannot be copied yet');
          },
        ),
      );
    }
  }

  void _deleteSelectedEvent() {
    if (_selectedEvent != null) {
      final event = context.read<BlueprintBloc>().state.items.firstWhere(
            (element) =>
                element.subject == _selectedEvent!.subject &&
                element.startTime == _selectedEvent!.startTime &&
                element.endTime == _selectedEvent!.endTime,
          );

      event.map(
        task: (task) => context.read<BlueprintBloc>().add(
              EventDeleted(
                event: event,
              ),
            ),
        event: (event) => showGeneralDialog(
          context: context,
          pageBuilder: (context, _, __) {
            return Text('Error, events cannot be deleted yet');
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlueprintBloc, BlueprintState>(
      builder: (context, state) {
        final l10n = context.l10n;

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
                          CalendarEventCreated(
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
              final calendarEvent = state.items.firstWhere(
                (element) => element.id == event.id,
              );

              context.read<BlueprintBloc>().add(
                    EventUpdated(
                      event: calendarEvent,
                      startTime: startDate,
                      endTime: endDate,
                    ),
                  );
            },
            events: [
              ...state.items.map(
                (e) => (
                  id: e.id,
                  subject: e.subject,
                  startTime: e.startTime,
                  endTime: e.endTime,
                  color: HexColor.fromHex(e.color),
                  type: e.map(
                    event: (event) => event.event.conferenceData != null
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
