import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/routes/router/app_router.dart';
import 'package:blueprint/blueprint/presentation/widgets/create_blueprint_dialog.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/core/utils/datetime/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

const _minEventDurationInMinutes = 5;

@RoutePage()
class CreateBlueprintPage extends StatelessWidget {
  const CreateBlueprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

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
              l10n.createTodaysBlueprintTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              l10n.createTodaysBlueprintDescription,
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
        final l10n = context.l10n;

        return EditableTimeline(
          newEventTemporaryName: l10n.newTaskTitle,
          createEventDialogBuilder: (context, event, hidePortal) {
            // Convert the start time to the nearest 15 minute interval
            final roundedStartTime = event.startTime.round(
              minutes: _minEventDurationInMinutes,
            );

            // Convert the end time to the nearest 15 minute interval
            final roundedEndTime = event.endTime.round(
              minutes: _minEventDurationInMinutes,
            );

            return CreateEventDialog(
              hidePortal: hidePortal,
              startTime: roundedStartTime,
              endTime: roundedEndTime,
              onAddTask: (task) {
                // TODO: add the task to the blueprint
              },
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
