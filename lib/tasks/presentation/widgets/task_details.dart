import 'package:app_ui/app_ui.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_repository/task_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetails extends StatelessWidget {
  /// Creates a [TaskDetails] widget that is displayed as a page.
  factory TaskDetails({
    required Task task,
    required VoidCallback onClose,
  }) {
    return TaskDetails._(
      task: task,
      onClose: onClose,
      isDialog: false,
    );
  }

  /// Creates a [TaskDetails] widget that is displayed as a dialog.
  factory TaskDetails.dialog({
    required Task task,
    required VoidCallback onClose,
  }) =>
      TaskDetails._(
        task: task,
        onClose: onClose,
        isDialog: true,
      );

  const TaskDetails._({
    required this.task,
    required this.onClose,
    required this.isDialog,
  });

  final Task task;
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
        appBar: _TaskDetailsAppBar(
          onClose: onClose,
          task: task,
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
                                _TaskDescriptionSection(
                                  task: task,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: AppSpacing.xlg,
                          ),
                          Expanded(
                            child: _TaskDetailsSection(
                              task: task,
                              isDialog: isDialog,
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
                    child: _TaskDescriptionSection(
                      task: task,
                    ),
                  ),
                  _buildDivider(),
                  Padding(
                    padding: padding,
                    child: _TaskDetailsSection(
                      task: task,
                      isDialog: isDialog,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _TaskDescriptionSection extends StatelessWidget {
  const _TaskDescriptionSection({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final text = task.description.isNotEmpty
        ? task.description
        : l10n.noDescriptionProvided;

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

class _TaskDetailsSection extends StatelessWidget {
  const _TaskDetailsSection({
    required this.task,
    required this.isDialog,
  });

  final Task task;
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
                _TaskLabels(task: task),
                const SizedBox(
                  height: AppSpacing.xlg,
                ),
                _StartAndDueDates(task: task),
                const SizedBox(
                  height: AppSpacing.xlg,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _TaskCreatedBy(
                        task: task,
                      ),
                    ),
                    Expanded(
                      child: _TaskAssignees(
                        task: task,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSpacing.xlg,
                ),
                _CreatedAndUpdatedDates(task: task),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreatedAndUpdatedDates extends StatelessWidget {
  const _CreatedAndUpdatedDates({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final createdAtFromNow = Jiffy.parseFromDateTime(task.createdAt).fromNow();
    final updatedAtFromNow = Jiffy.parseFromDateTime(task.updatedAt).fromNow();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.created} $createdAtFromNow',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          '${l10n.updated} $updatedAtFromNow',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _TaskCreatedBy extends StatelessWidget {
  const _TaskCreatedBy({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final creator = task.creator;

    return Section.mini(
      title: l10n.createdBy,
      child: Builder(
        builder: (context) {
          if (task.isBlueprintTask) {
            return UserTile.customLeading(
              displayName: creator.displayName,
              leading: AvatarIcon(text: creator.displayName[0]),
            );
          }
          return UserTile(
            platformUrl: creator.platformURL,
            avatarUrl: creator.avatarUrl,
            displayName: creator.displayName,
            // TODO(yarn-rp): add email to user entity
          );
        },
      ),
    );
  }
}

class _TaskAssignees extends StatelessWidget {
  const _TaskAssignees({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Section.mini(
      title: l10n.assignees,
      child: Wrap(
        children: task.assigned.map(
          (e) {
            if (task.isBlueprintTask) {
              // add check in here to see if the user is the current user
              return UserTile.customLeading(
                displayName: e.displayName,
                leading: AvatarIcon(text: e.displayName[0]),
              );
            }
            return UserTile(
              platformUrl: e.platformURL,
              avatarUrl: e.avatarUrl,
              displayName: e.displayName,
              leading: task.isBlueprintTask ? const BlueprintIcon() : null,
            );
          },
        ).toList(),
      ),
    );
  }
}

class _StartAndDueDates extends StatelessWidget {
  const _StartAndDueDates({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TaskStartDate(
            task: task,
          ),
        ),
        Expanded(
          child: _TaskDueDate(
            task: task,
          ),
        ),
      ],
    );
  }
}

class _TaskStartDate extends StatelessWidget {
  const _TaskStartDate({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Section.mini(
      title: l10n.startDate,
      child: SizedBox(
        width: double.infinity,
        child: TimeTile(
          time: task.startDate,
        ),
      ),
    );
  }
}

class _TaskDueDate extends StatelessWidget {
  const _TaskDueDate({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Section.mini(
      title: l10n.dueDate,
      child: SizedBox(
        width: double.infinity,
        child: TimeTile(
          time: task.dueDate,
        ),
      ),
    );
  }
}

class _TaskLabels extends StatelessWidget {
  const _TaskLabels({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final blueprint = context.select(
      (BlueprintBloc bloc) => bloc.state.items,
    );

    final isTaskInTodaysBlueprint = blueprint.any(
      (e) {
        final taskMatches = e.maybeMap(
          task: (value) => value.value.id == task.id,
          orElse: () => false,
        );

        return taskMatches &&
            e.startTime.isAfter(
              DateTime.now().copyWith(
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0,
              ),
            ) &&
            e.endTime.isBefore(
              DateTime.now().copyWith(
                hour: 23,
                minute: 59,
                second: 59,
                millisecond: 999,
                microsecond: 999,
              ),
            );
      },
    );

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ProjectPlatformChip(task: task),
        if (isTaskInTodaysBlueprint) const TodaysBlueprintChip(),
        PriorityChip(task: task),
        ...task.labels.map(
          (e) => LabelChip(
            text: e.name,
            backgroundColor: HexColor.fromHex(e.colorHex),
          ),
        ),
      ],
    );
  }
}

class _TaskDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _TaskDetailsAppBar({
    required this.onClose,
    required this.task,
  });

  final Task task;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight + kMinInteractiveDimension,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leadingWidth: double.infinity,
      actions: [
        if (task.isBlueprintTask)
          FilledButton.icon(
            onPressed: () => context.read<TasksCubit>().deleteTask(task),
            icon: const Icon(Icons.delete),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                theme.colorScheme.error,
              ),
            ),
            label: const Text(
              'Delete Task',
            ),
          )
        else
          FilledButton.tonalIcon(
            onPressed: () => launchUrl(task.taskURL),
            icon: const Icon(Icons.link),
            label: Text(
              l10n.viewInPlatformCTA(task.access.platform!.displayName),
            ),
          ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (task.isBlueprintTask)
            Text(
              'Made with Blueprint',
              style: theme.textTheme.bodySmall,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight + kMinInteractiveDimension,
      );
}
