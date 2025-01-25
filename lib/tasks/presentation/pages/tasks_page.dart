import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TasksPage extends StatefulWidget {
  const TasksPage({
    super.key,
  });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isWide = MediaQuery.of(context).size.width > 1200;

    if (isWide) {
      return const _WideTaskPage();
    }
    return const _NarrowTaskPage();
  }

  @override
  bool get wantKeepAlive => true;
}

class _WideTaskPage extends StatefulWidget {
  const _WideTaskPage();

  @override
  State<_WideTaskPage> createState() => _WideTaskPageState();
}

class _WideTaskPageState extends State<_WideTaskPage> {
  final MultiSplitViewController _controller = MultiSplitViewController();

  @override
  void initState() {
    super.initState();
    _controller.areas = [
      Area(
        data: 'tasks',
        size: 600,
        min: 300,
        builder: (context, area) => const _TasksList(),
      ),
      Area(
        data: 'taskDetails',
        flex: 1,
        builder: (context, area) => const _SelectedTaskDetails(),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xlg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.tasksPageTitle, style: textTheme.titleLarge),
          const SizedBox(
            height: AppSpacing.xlg,
          ),
          Row(
            children: [
              Flexible(
                child: FilledButton.icon(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 700,
                              maxHeight: 700,
                            ),
                            child: const MaterialDialog(
                              child: CreateTaskPage(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: Text(l10n.createTaskButtonLabel),
                ),
              ),
              const SizedBox(width: AppSpacing.xlg),
              const Expanded(
                flex: 5,
                child: _SearchTasksInputs(),
              ),
            ],
          ),
          const SizedBox(
            height: AppSpacing.xlg,
          ),
          Expanded(
            child: MultiSplitView(
              controller: _controller,
              builder: (context, area) => area.builder!(context, area),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedTaskDetails extends StatelessWidget {
  const _SelectedTaskDetails();

  @override
  Widget build(BuildContext context) {
    final selectedTask = context.select(
      (TasksCubit cubit) => cubit.state.selectedTask,
    );

    if (selectedTask == null) {
      return const SizedBox();
    }

    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 1200),
      child: TaskDetails(
        task: selectedTask,
        onClose: () => context.read<TasksCubit>().unselectTask(),
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Split the tasks between completed and todo tasks
    final todoTasks = context.select(
      (TasksCubit cubit) => cubit.state.todoTasks,
    );
    final completedTasks = context.select(
      (TasksCubit cubit) => cubit.state.completedTasks,
    );

    final selectedTask = context.select(
      (TasksCubit cubit) => cubit.state.selectedTask,
    );

    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 1200),
      child: ListView(
        children: [
          if (todoTasks.isEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Icon(
                    Icons.cancel_outlined,
                    size: 120,
                    color: theme.disabledColor,
                  ),
                  Text(
                    context.l10n.noTaskMatchesTitle,
                    style: textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    context.l10n.noTaskMatchesSubtitle,
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          else
            ...todoTasks.map(
              (task) => TaskCard(
                backgroundColor: selectedTask == task
                    ? colorScheme.secondaryContainer
                    : null,
                task: task,
                onTap: () => context.read<TasksCubit>().selectTask(task),
              ),
            ),
          // Completed tasks divider

          if (completedTasks.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xlg),
            Text('Completed Tasks', style: textTheme.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            const Divider(),
            const SizedBox(height: AppSpacing.xlg),
          ],
          ...completedTasks.map(
            (task) {
              final backgroundColor = selectedTask == task
                  ? colorScheme.secondaryContainer
                  : task.isCompleted
                      ? Theme.of(context).disabledColor
                      : null;
              return TaskCard(
                backgroundColor: backgroundColor,
                task: task,
                onTap: () => context.read<TasksCubit>().selectTask(task),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NarrowTaskPage extends StatelessWidget {
  const _NarrowTaskPage();

  @override
  Widget build(BuildContext context) {
    // Split the tasks between completed and todo tasks
    final todoTasks = context.select(
      (TasksCubit cubit) => cubit.state.todoTasks,
    );
    final completedTasks = context.select(
      (TasksCubit cubit) => cubit.state.completedTasks,
    );

    return ListView(
      children: [
        ...todoTasks.map(
          (task) => TaskCard(
            task: task,
            onTap: () async {
              await showDialog<void>(
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
                            task: task,
                            onClose: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Completed tasks divider

        if (completedTasks.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xlg),
          const Divider(),
          const SizedBox(height: AppSpacing.xlg),
        ],

        ...completedTasks.map(
          (task) => TaskCard(
            task: task,
            onTap: () async {
              await showDialog<void>(
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
                            task: task,
                            onClose: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SearchTasksInputs extends StatelessWidget {
  const _SearchTasksInputs();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
