import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/tasks/presentation/widgets/task_card.dart';
import 'package:blueprint/tasks/presentation/widgets/task_details.dart';
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
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final selectedTask = context.select(
      (TasksCubit cubit) => cubit.state.selectedTask,
    );

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xlg),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l10n.tasksPageTitle, style: textTheme.titleLarge),
              ),
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
            child: Row(
              children: [
                const Expanded(child: _TasksList()),
                const SizedBox(width: AppSpacing.xlg),
                if (selectedTask != null)
                  const Expanded(
                    flex: 2,
                    child: _SelectedTaskDetails(),
                  ),
              ],
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
    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 1200),
      child: ListView(
        children: [
          ...tasks.map(
            (task) => TaskCard(
              isHighlighted: selectedTask == task,
              task: task,
              onTap: () => context.read<TasksCubit>().selectTask(task),
            ),
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
    final tasks = context.select(
      (TasksCubit cubit) => cubit.state.tasks,
    );

    return ListView(
      children: [
        ...tasks.map(
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
                          child: TaskDetails(
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
