import 'package:app_ui/app_ui.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';

typedef TaskCreatedCallback = void Function(
  Task task,
  DateTime startTime,
  DateTime endTime,
);

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
  final TaskCreatedCallback onAddTask;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TasksCubit>()
        ..fetchPlatforms()
        ..fetchTasks(),
      child: _CreateEventView(
        startTime: startTime,
        endTime: endTime,
        hidePortal: hidePortal,
        onAddTask: onAddTask,
      ),
    );
  }
}

class _CreateEventView extends StatefulWidget {
  const _CreateEventView({
    required this.startTime,
    required this.endTime,
    required this.hidePortal,
    required this.onAddTask,
  });

  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback hidePortal;
  final TaskCreatedCallback onAddTask;

  @override
  State<_CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<_CreateEventView> {
  late DateTime starTime;
  late DateTime endTime;

  @override
  void initState() {
    starTime = widget.startTime;
    endTime = widget.endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      child: MaterialDialog(
        child: Scaffold(
          bottomNavigationBar: _ActionsBar(
            onCancelPressed: widget.hidePortal,
            // ignore: unnecessary_lambdas
            onAddPressed: () {
              final selectedTask =
                  context.read<TasksCubit>().state.selectedTask;

              if (selectedTask == null) {
                return;
              }

              widget.onAddTask(
                selectedTask,
                starTime,
                endTime,
              );
              widget.hidePortal();
            },
          ),
          appBar: AppBar(
            backgroundColor: theme.colorScheme.secondaryContainer,
            elevation: 0,
            actions: [
              CloseButton(
                color: theme.colorScheme.onSecondaryContainer,
                onPressed: widget.hidePortal,
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
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  onStartChanged: (value) {
                    setState(() {
                      starTime = value!;
                    });
                  },
                  onEndChanged: (value) {
                    setState(() {
                      endTime = value!;
                    });
                  },
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
              const Expanded(
                child: TasksList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tasks = context.select(
      (TasksCubit cubit) => cubit.state.tasks,
    );

    final selectedTask = context.select(
      (TasksCubit cubit) => cubit.state.selectedTask,
    );

    if (tasks.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Icon(
              Icons.cancel_outlined,
              size: 120,
              color: Theme.of(context).disabledColor,
            ),
            Text(
              context.l10n.noTaskMatchesTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.noTaskMatchesSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xlg,
        vertical: AppSpacing.md,
      ),
      children: tasks
          .map(
            (task) => TaskCard(
              onTap: () => context.read<TasksCubit>().selectTask(task),
              task: task,
              isHighlighted: selectedTask?.id == task.id,
            ),
          )
          .toList(),
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

    final sortOptions = context.select(
      (TasksCubit cubit) => cubit.state.sortOptions,
    );

    final sortBySelected = context.select(
      (TasksCubit cubit) => cubit.state.sortBy,
    );

    return BlueprintDropdown<String>(
      hintText: l10n.sortByDropdownHint,
      value: sortBySelected?.name,
      onChanged: (value) {
        final sortByValue = sortOptions.firstWhereOrNull(
          (element) => element.name == value,
        );

        context.read<TasksCubit>().fetchTasks(sortBy: sortByValue);
      },
      items: sortOptions.map((e) => e.name).toList(),
    );
  }
}

class _IntegrationsFilterDropdown extends StatelessWidget {
  const _IntegrationsFilterDropdown();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final platforms = context.select(
      (TasksCubit cubit) => cubit.state.platforms,
    );

    final selectedPlatform = context.select(
      (TasksCubit cubit) => cubit.state.selectedPlatform,
    );

    return BlueprintDropdown<String>(
      hintText: l10n.integrationsDropdownHint,
      value: selectedPlatform?.displayName,
      onChanged: (value) {
        final platformValue =
            platforms?.firstWhere((element) => element.displayName == value);

        context.read<TasksCubit>().fetchTasks(
              platform: platformValue,
            );
      },
      items: platforms?.map((e) => e.displayName).toList() ?? [],
    );
  }
}

class _SearchTaskBar extends StatelessWidget {
  const _SearchTaskBar();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SearchBar(
      onChanged: (value) {
        context.read<TasksCubit>().fetchTasks(query: value);
      },
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
    required this.onStartChanged,
    required this.onEndChanged,
  });

  final DateTime startTime;
  final DateTime endTime;
  final ValueChanged<DateTime?> onStartChanged;
  final ValueChanged<DateTime?> onEndChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StartTime(
            key: const ValueKey('start_time_selector'),
            value: TimeOfDay.fromDateTime(startTime),
            onChanged: (TimeOfDay? value) {
              final newStartTime = DateTime(
                startTime.year,
                startTime.month,
                startTime.day,
                value!.hour,
                value.minute,
              );

              onStartChanged(newStartTime);
            },
          ),
        ),
        Expanded(
          child: _EndTime(
            key: const ValueKey('end_time_selector'),
            value: TimeOfDay.fromDateTime(endTime),
            onChanged: (TimeOfDay? value) {
              final newEndTime = DateTime(
                endTime.year,
                endTime.month,
                endTime.day,
                value!.hour,
                value.minute,
              );

              onEndChanged(newEndTime);
            },
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
