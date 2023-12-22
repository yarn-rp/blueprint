import 'package:app_ui/app_ui.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

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
      platformName: 'Github',
      description: '',
      colorHex: '#FF0000',
    ),
    taskURL: Uri.parse('https://example.com/task'),
    title: 'Example Task',
    description: 'This is an example task description.',
    startDate: DateTime.now(),
    dueDate: DateTime.now().add(const Duration(days: 7)),
    estimatedTime: const Duration(hours: 2),
    loggedTime: const Duration(minutes: 30),
    assigned: [],
    creator: const User('', '', ''),
    isCompleted: false,
    labels: [
      Label('Priority high', '#ef9930'),
      Label('Beta 1', '#4f9856'),
      Label('MVP', '#009857'),
    ],
    priority: 3,
  ),
];

class CreateEventDialog extends StatelessWidget {
  const CreateEventDialog({
    required this.startTime,
    required this.endTime,
    required this.hidePortal,
    required this.onAddTask,
    super.key,
  });

  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback hidePortal;
  final ValueChanged<CalendarEvent> onAddTask;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      child: MaterialDialog(
        child: Scaffold(
          bottomNavigationBar: _ActionsBar(
            onCancelPressed: hidePortal,
            // ignore: unnecessary_lambdas
            onAddPressed: () {
              // TODO(yarn-rp): call onAddTask with the selected task
              hidePortal();
            },
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
                      .map(
                        (task) => EventCard(
                          labels: [
                            LabelChip(
                              text: task.project.platformName,
                              backgroundColor:
                                  HexColor.fromHex(task.project.colorHex),
                            ),
                            ...task.labels.map(
                              (e) => LabelChip(
                                text: e.name,
                                backgroundColor: HexColor.fromHex(e.colorHex),
                              ),
                            ),
                          ],
                          title: EventListTile.task(
                            title: task.title,
                            subtitle: task.description,
                          ),
                        ),
                      )
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
    required this.onCancelPressed,
    required this.onAddPressed,
  });

  final VoidCallback onCancelPressed;
  final VoidCallback? onAddPressed;

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
            onPressed: onCancelPressed,
          ),
          const SizedBox(width: AppSpacing.sm),
          _AddTaskButton(
            onPressed: onAddPressed,
          ),
        ],
      ),
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  const _AddTaskButton({
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FilledButton(
      onPressed: onPressed,
      child: Text(l10n.create),
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
    final l10n = context.l10n;

    return TextButton(
      onPressed: onPressed,
      child: Text(
        l10n.cancel,
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
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.selectTask,
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
    final l10n = context.l10n;

    return BlueprintDropdown<String>(
      hintText: l10n.sortByDropdownHint,
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
    final l10n = context.l10n;
    return BlueprintDropdown<String>(
      hintText: l10n.integrationsDropdownHint,
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
    final l10n = context.l10n;

    return SearchBar(
      trailing: const [
        Icon(Icons.search),
      ],
      hintText: l10n.search,
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
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.startTime,
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
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.endTime,
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
