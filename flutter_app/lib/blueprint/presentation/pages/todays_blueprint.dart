import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_e_task/blueprint/entities/calendar_event.dart';
import 'package:poll_e_task/blueprint/presentation/widgets/calendar_event_tile.dart';
import 'package:poll_e_task/blueprint/presentation/widgets/task_event_tile.dart';
import 'package:poll_e_task/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:poll_e_task/tasks/presentation/pages/task_details.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodaysBlueprint extends StatefulWidget {
  const TodaysBlueprint({
    super.key,
  });

  @override
  State<TodaysBlueprint> createState() => _TodaysBlueprintState();
}

class _TodaysBlueprintState extends State<TodaysBlueprint> {
  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  final GlobalKey _globalKey = GlobalKey();
  final ScrollController _controller = ScrollController();
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        )
                      ],
                    ),
                  )
                : calendar,
          )
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
          minDate: now.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
          maxDate: now.copyWith(
            hour: 23,
            minute: 59,
            second: 59,
            millisecond: 999,
          ),
          specialRegions: [
            TimeRegion(
              text: 'Working Time',
              startTime: DateTime.now().copyWith(
                hour: 6,
                minute: 30,
                microsecond: 0,
                second: 0,
              ),
              endTime: DateTime.now().copyWith(
                hour: 19,
                minute: 0,
                microsecond: 0,
                second: 0,
              ),
            )
          ],

          onTap: (calendarTapDetails) async {
            if (calendarTapDetails.targetElement ==
                CalendarElement.appointment) {
              final appointment = calendarTapDetails.appointments?.first;
              if (appointment is! CalendarEvent) {
                return;
              }
              await appointment.map(
                event: (event) {
                  // TODO: do something
                },
                task: (appointment) async {
                  await showDialog(
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
          // For example, if the appointment is dragged to 10:05, the appointment
          // time will be rounded to 10:00. If the appointment is dragged to 10:07,
          // the appointment time will be rounded to 10:15. If the appointment is
          // dragged to 10:27, the appointment time will be rounded to 10:30. If the
          // appointment is dragged to 10:16, the appointment time will be rounded
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
          appointmentBuilder: (
            BuildContext context,
            CalendarAppointmentDetails calendarAppointmentDetails,
          ) {
            final appointment = calendarAppointmentDetails.appointments.first;
            if (appointment is! CalendarEvent) {
              return const SizedBox();
            }
            return appointment.map(
              event: (appointment) =>
                  CalendarEventTile(appointment: appointment),
              task: (appointment) => TaskEventTile(
                appointment: appointment,
              ),
            );
          },
          timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 15),
            timeIntervalHeight: MediaQuery.of(context).size.height / 14,
          ),
        );
      },
    );
  }
}
