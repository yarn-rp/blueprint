import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/routes/router/app_router.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_repository/task_repository.dart';

const _minEventDurationInMinutes = 5;
final fakeData = <Task>[
  Task(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    id: 'example_id',
    project: Project(
      id: 'example_project_id',
      name: 'Example Project',
      platformId: '',
      platformURL: Uri(),
      platformName: '',
      description: '',
      colorHex: '',
    ),
    taskURL: Uri.parse('https://example.com/task'),
    title: 'Example Task',
    description: 'This is an example task description.',
    startDate: DateTime.now(),
    dueDate: DateTime.now().add(const Duration(days: 7)),
    estimatedTime: const Duration(hours: 2),
    loggedTime: const Duration(minutes: 30),
    assigned: [],
    creator: User('', '', ''),
    isCompleted: false,
    labels: [
      Label('label1', 'Label 1'),
      Label('label2', 'Label 2'),
    ],
    priority: 3,
  ),
];

@RoutePage()
class CreateBlueprintPage extends StatelessWidget {
  const CreateBlueprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              "Create Today's Blueprint",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Click or drag to create new entries',
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

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodaysBlueprintCubit, TodaysBlueprintState>(
      builder: (context, state) {
        return EditableTimeline(
          createEventDialogBuilder: (context, event, hidePortal) {
            // Convert the start time to the nearest 15 minute interval
            final roundedStartTime = event.startTime.copyWith(
              minute: _minEventDurationInMinutes *
                  (Jiffy(event.startTime).minute / _minEventDurationInMinutes)
                      .round(),
            );

            // Convert the end time to the nearest 15 minute interval
            final roundedEndTime = event.endTime.copyWith(
              minute: _minEventDurationInMinutes *
                  (Jiffy(event.endTime).minute / _minEventDurationInMinutes)
                      .round(),
            );

            return CreateEventDialog(
              hidePortal: hidePortal,
              startTime: roundedStartTime,
              endTime: roundedEndTime,
            );
          },
          intervalHeight: 140,
          onEventUpdate: (event, startDate, endDate) {},
          events: [
            ...state.calendarEvents.map((e) {
              return (
                subject: e.subject,
                startTime: e.startTime,
                endTime: e.endTime,
                color: HexColor.fromHex(e.color),
                shouldDisplayTime: true,
                typeLabel: e.map(
                  event: (event) => event.event.conferenceData != null
                      ? EventTypeLabel.videoConference()
                      : EventTypeLabel.calendar(),
                  task: (task) => EventTypeLabel.calendar(),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class CreateEventDialog extends StatelessWidget {
  const CreateEventDialog({
    required this.startTime,
    required this.endTime,
    required this.hidePortal,
    super.key,
  });

  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback hidePortal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      child: MaterialDialog(
        child: Scaffold(
          bottomNavigationBar: _ActionsBar(
            hidePortal: hidePortal,
          ),
          appBar: AppBar(
            backgroundColor: theme.colorScheme.secondaryContainer,
            elevation: 0,
            actions: [
              CloseButton(
                color: theme.colorScheme.onSecondaryContainer,
                onPressed: hidePortal,
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: AppSpacing.xxlg,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
                child: _TaskTimeSelection(
                  startTime: startTime,
                  endTime: endTime,
                ),
              ),
              const SizedBox(
                height: AppSpacing.xxlg,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
                child: _SearchTasksInputs(),
              ),
              const SizedBox(
                height: AppSpacing.lg,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xlg,
                    vertical: AppSpacing.md,
                  ),
                  children: fakeData
                      .map((task) => EventCard(
                            labels: task.labels
                                .map(
                                  (e) => LabelChip(
                                    text: e.name,
                                    backgroundColor: Colors.amber,
                                  ),
                                )
                                .toList(),
                            title: EventListTile.task(
                              title: task.title,
                              subtitle: task.description,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionsBar extends StatelessWidget {
  const _ActionsBar({
    this.hidePortal,
  });

  final VoidCallback? hidePortal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xlg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _CancelButton(
            onPressed: hidePortal,
          ),
          const SizedBox(width: AppSpacing.sm),
          const _AddTaskButton(),
        ],
      ),
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  const _AddTaskButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      child: const Text(
        'Create',
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Cancel',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _SearchTasksInputs extends StatelessWidget {
  const _SearchTasksInputs();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a Task',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        const Row(
          children: [
            Expanded(
              flex: 3,
              child: _SearchTaskBar(),
            ),
            SizedBox(width: AppSpacing.xxlg),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: _IntegrationsFilterDropdown(),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _SortByFilterDropdown(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SortByFilterDropdown extends StatelessWidget {
  const _SortByFilterDropdown();

  @override
  Widget build(BuildContext context) {
    return BlueprintDropdown<String>(
      hintText: 'Sort By',
      onChanged: (value) {},
      items: const [
        'Due Date',
        'Priority',
      ],
    );
  }
}

class _IntegrationsFilterDropdown extends StatelessWidget {
  const _IntegrationsFilterDropdown();

  @override
  Widget build(BuildContext context) {
    return BlueprintDropdown<String>(
      hintText: 'Integrations',
      onChanged: (value) {},
      items: const [
        'All',
        'Asana',
        'Jira',
        'Github',
      ],
    );
  }
}

class _SearchTaskBar extends StatelessWidget {
  const _SearchTaskBar();

  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      trailing: [
        Icon(
          Icons.search,
        ),
      ],
      hintText: 'Search',
    );
  }
}

class _TaskTimeSelection extends StatelessWidget {
  const _TaskTimeSelection({
    required this.startTime,
    required this.endTime,
  });

  final DateTime startTime;
  final DateTime endTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StartTime(
            key: const ValueKey('start_time_selector'),
            value: TimeOfDay.fromDateTime(startTime),
            onChanged: (TimeOfDay? value) {},
          ),
        ),
        Expanded(
          child: _EndTime(
            key: const ValueKey('end_time_selector'),
            value: TimeOfDay.fromDateTime(endTime),
            onChanged: (TimeOfDay? value) {},
          ),
        ),
      ],
    );
  }
}

class _StartTime extends StatelessWidget {
  const _StartTime({
    required this.onChanged,
    this.value,
    super.key,
  });

  final ValueChanged<TimeOfDay?> onChanged;
  final TimeOfDay? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start time',
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(
          width: double.infinity,
          child: TimeOfDaySelectorDropdown(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _EndTime extends StatelessWidget {
  const _EndTime({
    required this.onChanged,
    this.value,
    super.key,
  });

  final ValueChanged<TimeOfDay?> onChanged;
  final TimeOfDay? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'End time',
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(
          width: double.infinity,
          child: TimeOfDaySelectorDropdown(
            onChanged: onChanged,
            value: value,
          ),
        ),
      ],
    );
  }
}
