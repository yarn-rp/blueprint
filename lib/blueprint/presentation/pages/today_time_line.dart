import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:blueprint/blueprint/presentation/widgets/general_calendar_event_tile.dart';
import 'package:blueprint/blueprint/presentation/widgets/task_event_tile.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/calendar/presentation/views/event_details.dart';
import 'package:blueprint/tasks/presentation/pages/task_details.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodayTimeline extends StatefulWidget {
  const TodayTimeline({
    super.key,
  });

  @override
  State<TodayTimeline> createState() => _TodaysBlueprintState();
}

class _TodaysBlueprintState extends State<TodayTimeline>
    with AutomaticKeepAliveClientMixin {
  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  final GlobalKey _globalKey = GlobalKey();
  final ScrollController _controller = ScrollController();
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Widget calendar = Theme(
      /// The key set here to maintain the state,
      ///  when we change the parent of the widget
      key: _globalKey,
      data: Theme.of(context),
      child: _getDragAndDropCalendar(
        _calendarController,
      ),
    );

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: screenHeight < 800
                ? Scrollbar(
                    thumbVisibility: true,
                    controller: _controller,
                    child: ListView(
                      controller: _controller,
                      children: <Widget>[
                        SizedBox(
                          height: 600,
                          child: calendar,
                        ),
                      ],
                    ),
                  )
                : calendar,
          ),
        ],
      ),
    );
  }

  /// Refers to the minimum duration you can move in the timeline.
  final dragUnit = 5;

  /// Returns the calendar widget based on the properties passed.
  Widget _getDragAndDropCalendar([
    CalendarController? calendarController,
  ]) {
    final now = DateTime.now();

    return BlocBuilder<TodaysBlueprintCubit, TodaysBlueprintState>(
      builder: (context, state) {
        return SfCalendar(
          controller: calendarController,
          dataSource: state.toDataSource,
          allowDragAndDrop: true,
          allowAppointmentResize: true,
          appointmentTextStyle: Theme.of(context).textTheme.bodyMedium!,
          todayTextStyle: Theme.of(context).textTheme.bodyMedium,
          blackoutDatesTextStyle: Theme.of(context).textTheme.bodyMedium,
          weekNumberStyle: WeekNumberStyle(
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),

          onTap: (calendarTapDetails) async {
            if (calendarTapDetails.targetElement ==
                CalendarElement.appointment) {
              final appointment = calendarTapDetails.appointments?.first;
              if (appointment is! CalendarEvent) {
                return;
              }
              await appointment.map(
                event: (appointment) async {
                  await showDialog<void>(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        surfaceTintColor: Theme.of(context).canvasColor,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 1200,
                            maxHeight: MediaQuery.of(context).size.height,
                          ),
                          child: GeneralEventCalendarEventDetails(
                            appointment: appointment,
                            onClose: () => Navigator.of(context).pop(),
                          ),
                        ),
                      );
                    },
                  );
                },
                task: (appointment) async {
                  await showDialog<void>(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        surfaceTintColor: Theme.of(context).canvasColor,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 1200,
                            maxHeight: MediaQuery.of(context).size.height,
                          ),
                          child: TaskDetails(
                            task: appointment.task,
                            onClose: () => Navigator.of(context).pop(),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
          // Rounds the new appointment time to the nearest 15 minutes interval.
          // For example, if the appointment is dragged to 10:05, the
          // appointment time will be rounded to 10:00. If the appointment is
          // dragged to 10:07, the appointment time will be rounded to 10:15.
          // If the appointment is dragged to 10:27, the appointment time will
          // be rounded to 10:30. If the appointment is dragged to 10:16, the
          // appointment time will be rounded
          // to 10:15.
          onDragEnd: (AppointmentDragEndDetails details) {
            final appointment = details.appointment;

            if (appointment == null) {
              return;
            }

            if (appointment is! CalendarEvent) {
              return;
            }
            final startTime = appointment.startTime;
            final endTime = appointment.endTime;

            final newStartTime = DateTime(
              startTime.year,
              startTime.month,
              startTime.day,
              startTime.hour,
              (startTime.minute / dragUnit).round() * dragUnit,
            );

            final newEndTime = DateTime(
              endTime.year,
              endTime.month,
              endTime.day,
              endTime.hour,
              (endTime.minute / dragUnit).round() * dragUnit,
            );
            context.read<TodaysBlueprintCubit>().moveEventInTimeLine(
                  appointment,
                  newStartTime,
                  newEndTime,
                );
          },

          onAppointmentResizeEnd: (appointmentResizeEndDetails) {
            final appointment = appointmentResizeEndDetails.appointment;
            if (appointment is! CalendarEvent) {
              return;
            }
            final startTime = appointment.startTime;
            final endTime = appointment.endTime;

            final newStartTime = DateTime(
              startTime.year,
              startTime.month,
              startTime.day,
              startTime.hour,
              (startTime.minute / dragUnit).round() * dragUnit,
            );

            final newEndTime = DateTime(
              endTime.year,
              endTime.month,
              endTime.day,
              endTime.hour,
              (endTime.minute / dragUnit).round() * dragUnit,
            );
            context.read<TodaysBlueprintCubit>().moveEventInTimeLine(
                  appointment,
                  newStartTime,
                  newEndTime,
                );
          },

          appointmentBuilder: (
            BuildContext context,
            CalendarAppointmentDetails calendarAppointmentDetails,
          ) {
            final appointment = calendarAppointmentDetails.appointments.last;
            if (appointment is! CalendarEvent) {
              return const SizedBox();
            }

            final isAfter = appointment.endTime.isAfter(now);
            final originalColor = appointment.color != null
                ? HexColor.fromHex(
                    appointment.color!,
                  )
                : Theme.of(context).colorScheme.secondary;

            return appointment.map(
              event: (appointment) => GeneralCalendarEventTile(
                appointment: appointment,
                isSmallVersion: appointment.endTime
                        .difference(appointment.startTime)
                        .inMinutes <=
                    30,
                color:
                    isAfter ? originalColor : originalColor?.withOpacity(0.5),
              ),
              task: (appointment) => TaskEventTile(
                appointment: appointment,
                color:
                    isAfter ? originalColor : originalColor?.withOpacity(0.5),
              ),
            );
          },
          timeSlotViewSettings: TimeSlotViewSettings(
            timeTextStyle: Theme.of(context).textTheme.labelMedium,
            minimumAppointmentDuration: const Duration(minutes: 15),
            timeIntervalHeight: state.calendarEvents.isEmpty
                ? 100
                : state.calendarEvents
                    .map(
                      (value) => max(
                        value.endTime.difference(value.startTime).inMinutes * 5,
                        80,
                      ),
                    )
                    .reduce(min)
                    .toDouble(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
