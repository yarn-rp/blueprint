import 'package:app_ui/app_ui.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/tasks/presentation/widgets/widgets.dart';
import 'package:blueprint/tasks/state_management/bloc/create_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateTaskBloc>(),
      child: _CreateTaskView(
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: kToolbarHeight + kMinInteractiveDimension,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          leadingWidth: double.infinity,
          actions: [
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ],
          title: Text(
            context.l10n.createTaskButtonLabel,
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
                  const Row(
                    children: [
                      _TaskDueDateInput(),
                      _TaskPriorityInput(),
                    ],
                  ),
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
    return TextField(
      onChanged: (value) => context.read<CreateTaskBloc>().add(
            TitleChanged(value),
          ),
      decoration: InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _TaskDescriptionInput extends StatelessWidget {
  const _TaskDescriptionInput();
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<CreateTaskBloc>().add(
            DescriptionChanged(value),
          ),
      decoration: InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }
}

class _TaskDueDateInput extends StatelessWidget {
  const _TaskDueDateInput();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        const Icon(Icons.calendar_today),
        const SizedBox(width: AppSpacing.sm),
        TextButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1),
            );

            if (selectedDate != null) {
              context.read<CreateTaskBloc>().add(
                    DueDateChanged(selectedDate),
                  );
            }
          },
          child: Text(
            'Due Date',
            style: theme.textTheme.bodyMedium,
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
    final value = context.select((CreateTaskBloc bloc) => bloc.state.priority);

    return Row(
      children: [
        const Icon(Icons.flag),
        const SizedBox(width: AppSpacing.sm),
        DropdownButton<int>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: theme.textTheme.bodyMedium,
          underline: Container(
            height: 2,
            color: theme.colorScheme.secondary,
          ),
          onChanged: (int? newValue) {
            if (newValue != null) {
              context.read<CreateTaskBloc>().add(PriorityChanged(newValue));
            }
          },
          items: List<DropdownMenuItem<int>>.generate(
            5,
            (index) => DropdownMenuItem<int>(
              value: index + 1,
              child: Text('${index + 1}'),
            ),
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
    final theme = Theme.of(context);

    return FilledButton(
      onPressed: () {
        context.read<CreateTaskBloc>().add(
              CreateTaskSubmitted(),
            );
      },
      child: Text(
        'Submit',
      ),
    );
  }
}
