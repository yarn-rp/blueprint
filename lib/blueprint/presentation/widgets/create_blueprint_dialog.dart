import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

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
                  children: [
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'In Progress',
                          backgroundColor: Colors.blue,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement Create Blueprint dialog',
                        subtitle:
                            'Implement dialog to create blueprint using Portal '
                            'widget and build this amazing UI. ',
                      ),
                    ),
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'TO DO',
                          backgroundColor: Colors.yellow,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement bloc for Create Blueprint',
                        subtitle:
                            'Implement bloc that manages the state of the '
                            'Create Blueprint dialog.',
                      ),
                    ),
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'In Progress',
                          backgroundColor: Colors.blue,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement Create Blueprint dialog',
                        subtitle:
                            'Implement dialog to create blueprint using Portal '
                            'widget and build this amazing UI. ',
                      ),
                    ),
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'TO DO',
                          backgroundColor: Colors.yellow,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement bloc for Create Blueprint',
                        subtitle:
                            'Implement bloc that manages the state of the '
                            'Create Blueprint dialog.',
                      ),
                    ),
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'In Progress',
                          backgroundColor: Colors.blue,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement Create Blueprint dialog',
                        subtitle:
                            'Implement dialog to create blueprint using Portal '
                            'widget and build this amazing UI. ',
                      ),
                    ),
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'TO DO',
                          backgroundColor: Colors.yellow,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement bloc for Create Blueprint',
                        subtitle:
                            'Implement bloc that manages the state of the '
                            'Create Blueprint dialog.',
                      ),
                    ),
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'In Progress',
                          backgroundColor: Colors.blue,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement Create Blueprint dialog',
                        subtitle:
                            'Implement dialog to create blueprint using Portal '
                            'widget and build this amazing UI. ',
                      ),
                    ),
                    EventCard(
                      labels: const [
                        LabelChip(
                          text: 'TO DO',
                          backgroundColor: Colors.yellow,
                        ),
                        LabelChip(
                            text: 'MVP', backgroundColor: Colors.green,),
                      ],
                      title: EventListTile.task(
                        title: 'Implement bloc for Create Blueprint',
                        subtitle:
                            'Implement bloc that manages the state of the '
                            'Create Blueprint dialog.',
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
    return ButtonTheme(
      height: 52,
      child: FilledButton(
        onPressed: () {},
        child: const Text(
          'Create',
        ),
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
