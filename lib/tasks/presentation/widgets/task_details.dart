import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/tasks/presentation/widgets/priority_chip.dart';
import 'package:blueprint/tasks/presentation/widgets/status_chip.dart';
import 'package:blueprint/tasks/presentation/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jiffy/jiffy.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:task_repository/task_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    required this.task,
    required this.onClose,
    this.padding = 32,
    super.key,
  });

  final Task task;
  final VoidCallback onClose;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: _TaskDetailsAppBar(
          padding: padding,
          onClose: onClose,
          platformTaskUrl: task.taskURL,
          platformName: task.project.platformName,
          taskTitle: task.title,
        ),
        body: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16)
                      .copyWith(right: 64),
                  children: [
                    _TaskDescription(
                      description: task.description,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    if (task.estimatedTime != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Original estimation'),
                          const SizedBox(
                            height: 16,
                          ),
                          // Use jiffy to format the date
                          Text(
                            task.estimatedTime!.inHours > 0
                                ? '${task.estimatedTime!.inHours}h '
                                    '${task.estimatedTime!.inMinutes % 60}m'
                                : '${task.estimatedTime!.inMinutes % 60}m',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      // Divider
                      const Divider(
                        endIndent: 0,
                        indent: 0,
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Wrap(
                        spacing: 8,
                        children: [
                          // ProjectChip(project: task.project),
                          ...task.labels.map((e) => LabelChip(label: e)),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Time logged'),
                          const SizedBox(
                            height: 16,
                          ),
                          // A percentage bar showing the time logged
                          if (task.loggedTime != null &&
                              task.estimatedTime != null)
                            Column(
                              children: [
                                LinearProgressIndicator(
                                  value: task.loggedTime!.inMilliseconds /
                                      task.estimatedTime!.inMilliseconds,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(
                                        0.3,
                                      ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (task.loggedTime != null &&
                                    task.estimatedTime != null)
                                  Row(
                                    children: [
                                      if (task.loggedTime != null)
                                        Text(
                                          '${task.loggedTime!.inHours}h '
                                          '${task.loggedTime!.inMinutes % 60}m',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      const Spacer(),
                                      if (task.estimatedTime != null)
                                        Text(
                                          '${task.estimatedTime!.inHours}h '
                                          // ignore: lines_longer_than_80_chars
                                          '${task.estimatedTime!.inMinutes % 60}m',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                        ],
                      ),
                      // Starting date and due date of the task
                      const SizedBox(
                        height: 32,
                      ),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Starting date'),
                              const SizedBox(
                                height: 16,
                              ),
                              // Use jiffy to format the date
                              Text(
                                Jiffy(task.startDate)
                                    .format('dd MMM yyyy hh:mm a'),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Due date'),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Text(
                                    Jiffy(
                                      task.dueDate,
                                    ).fromNow(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color:
                                              Theme.of(context).highlightColor,
                                        ),
                                  ),
                                  const Text(' - '),
                                  Expanded(
                                    child: Text(
                                      Jiffy(task.dueDate).format(
                                        'dd MMM yyyy hh:mm a',
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Priority of the task
                      const SizedBox(
                        height: 32,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Priority'),
                          const SizedBox(
                            height: 16,
                          ),
                          PriorityChip(
                            task: task,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Creator'),
                                const SizedBox(
                                  height: 16,
                                ),
                                Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Creator'),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          UserTile(
                                            platformUrl:
                                                task.creator.platformURL,
                                            avatarUrl: task.creator.avatarUrl,
                                            displayName:
                                                task.creator.displayName,
                                            email: null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Assignees'),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ...task.assigned.map(
                                            (e) => UserTile(
                                              platformUrl: e.platformURL,
                                              avatarUrl: e.avatarUrl,
                                              displayName: e.displayName,
                                              email: null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Assignees'),
                                const SizedBox(
                                  height: 16,
                                ),
                                ...task.assigned.map(
                                  (e) => UserTile(
                                    platformUrl: e.platformURL,
                                    avatarUrl: e.avatarUrl,
                                    displayName: e.displayName,
                                    email: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 16,
                      ),
                      // Updated at and created at of the task
                      // Use jiffy to format the date
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Created at '
                                // ignore: lines_longer_than_80_chars
                                '${Jiffy(task.createdAt).format('dd MMM yyyy hh:mm a')}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Updated at '
                                // ignore: lines_longer_than_80_chars
                                '${Jiffy(task.updatedAt).format('dd MMM yyyy hh:mm a')}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskDescription extends StatelessWidget {
  const _TaskDescription({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Text(
          l10n.description,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Card(
          margin: EdgeInsets.zero,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: MarkdownBody(
                selectable: true,
                data: description,
                extensionSet: md.ExtensionSet(
                  md.ExtensionSet.commonMark.blockSyntaxes,
                  [
                    md.EmojiSyntax(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _TaskDetailsAppBar({
    required this.padding,
    required this.onClose,
    required this.platformTaskUrl,
    required this.platformName,
    required this.taskTitle,
  });

  final double padding;
  final Uri platformTaskUrl;
  final String platformName;
  final String taskTitle;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight + kMinInteractiveDimension + padding,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leadingWidth: double.infinity,
      actions: [
        FilledButton.tonalIcon(
          onPressed: () => launchUrl(platformTaskUrl),
          icon: const Icon(Icons.link),
          label: Text(
            'View in $platformName',
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ],
      title: Text(
        taskTitle,
        style: Theme.of(context).textTheme.headlineMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + kMinInteractiveDimension + padding,
      );
}
