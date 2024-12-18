import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:blueprint/tasks/state_management/bloc/create_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateTaskBloc>(),
      child: _CreateTaskView.dialog(
        onClose: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _CreateTaskView extends StatelessWidget {
  /// Creates a [_CreateTaskView] widget that is displayed as a page.
  factory _CreateTaskView({
    required VoidCallback onClose,
  }) {
    return _CreateTaskView._(
      onClose: onClose,
      isDialog: false,
    );
  }

  /// Creates a [TaskDetails] widget that is displayed as a dialog.
  factory _CreateTaskView.dialog({
    required VoidCallback onClose,
  }) =>
      _CreateTaskView._(
        onClose: onClose,
        isDialog: true,
      );

  const _CreateTaskView._({
    required this.onClose,
    required this.isDialog,
  });

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
        appBar: isDialog
            ? AppBar(
                backgroundColor: theme.colorScheme.secondaryContainer,
                elevation: 0,
                leading: const SizedBox(),
                actions: [
                  CloseButton(
                    color: theme.colorScheme.onSecondaryContainer,
                    onPressed: onClose,
                  ),
                ],
              )
            : null,
        // AppBar(
        //   automaticallyImplyLeading: false,
        //   toolbarHeight: kToolbarHeight + kMinInteractiveDimension,
        //   backgroundColor: Colors.transparent,
        //   centerTitle: false,
        //   leadingWidth: double.infinity,
        //   actions: [
        //     IconButton(
        //       onPressed: onClose,
        //       icon: const Icon(Icons.close),
        //     ),
        //   ],
        //   title: Text(
        //     context.l10n.createTaskButtonLabel,
        //     style: Theme.of(context).textTheme.headlineMedium,
        //     maxLines: 2,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _TaskSubmitButton(),
            ],
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  const _TaskTitleInput(),
                  _buildDivider(),
                  const _TaskDescriptionInput(),
                  _buildDivider(),
                  const _TaskDueDateAndEstimatedTimeInput(),
                  _buildDivider(),
                  const _TaskPriorityInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskTitleInput extends StatelessWidget {
  const _TaskTitleInput();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title *',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          onChanged: (value) => context.read<CreateTaskBloc>().add(
                TitleChanged(value),
              ),
          decoration: const InputDecoration(
            hintText: 'Write a title for the task',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class _TaskDescriptionInput extends StatelessWidget {
  const _TaskDescriptionInput();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description *',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          onChanged: (value) => context.read<CreateTaskBloc>().add(
                DescriptionChanged(value),
              ),
          decoration: const InputDecoration(
            hintText: 'Write a description for the task',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
      ],
    );
  }
}

class _TaskDueDateAndEstimatedTimeInput extends StatelessWidget {
  const _TaskDueDateAndEstimatedTimeInput();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Flexible(child: _DueDateInput()),
        SizedBox(width: AppSpacing.lg),
        Flexible(child: _EstimatedTimeInput()),
      ],
    );
  }
}

class _EstimatedTimeInput extends StatelessWidget {
  const _EstimatedTimeInput();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estimated Time',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text('Optional', style: theme.textTheme.labelSmall),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: 64,
          child: TextField(
            onChanged: (value) {
              final duration = Duration(hours: double.parse(value).toInt());

              context.read<CreateTaskBloc>().add(
                    EstimatedTimeChanged(duration),
                  );
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              suffixText: 'h',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }
}

class _DueDateInput extends StatelessWidget {
  const _DueDateInput();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text('Optional', style: theme.textTheme.labelSmall),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: (value) {
              final valueSplit = value.split('/');

              if (valueSplit.length != 3) {
                return;
              }

              final date = DateTime.tryParse(
                '${valueSplit[2]}-${valueSplit[0]}-${valueSplit[1]}',
              );

              if (date != null) {
                context.read<CreateTaskBloc>().add(
                      DueDateChanged(date),
                    );
              }
            },
            inputFormatters: [
              DateTextFormatter(),
            ],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'MM/DD/YYYY',
            ),
            keyboardType: TextInputType.datetime,
          ),
        ),
      ],
    );
  }
}

class _TaskPriorityInput extends StatelessWidget {
  const _TaskPriorityInput();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedPriority = context.select(
      (CreateTaskBloc bloc) => bloc.state.priority,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
          style: theme.textTheme.titleMedium,
        ),
        Text('Optional', style: theme.textTheme.labelSmall),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: List.generate(
            5,
            (index) {
              final priority = 5 - index;
              return Padding(
                padding: const EdgeInsets.all(4),
                child: IconButton.filled(
                  style: selectedPriority == priority
                      ? ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            theme.colorScheme.primaryFixed,
                          ),
                        )
                      : ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            getPriorityColor(priority),
                          ),
                        ),
                  icon: Icon(getPriorityIcon(priority)),
                  onPressed: () {
                    context.read<CreateTaskBloc>().add(
                          PriorityChanged(priority),
                        );
                  },
                  iconSize: 32,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TaskSubmitButton extends StatelessWidget {
  const _TaskSubmitButton();

  @override
  Widget build(BuildContext context) {
    final isValid = context.select(
      (CreateTaskBloc bloc) => bloc.state.isValid,
    );

    return FilledButton(
      onPressed: isValid
          ? () => context.read<CreateTaskBloc>().add(
                const CreateTaskSubmitted(),
              )
          : null,
      child: const Text('Create'),
    );
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String separator) {
    final formattedValue = value.replaceAll(separator, '');
    final newString = StringBuffer();

    for (var i = 0; i < min(formattedValue.length, _maxChars); i++) {
      // ignore: use_string_buffers
      newString.write(formattedValue[i]);
      if ((i == 1 || i == 3) && i != formattedValue.length - 1) {
        newString.write(separator);
      }
    }

    return newString.toString();
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
