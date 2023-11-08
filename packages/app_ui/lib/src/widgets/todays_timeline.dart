import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

enum EventType { videoConference, event, task }

typedef TodayEvent = ({
  String subject,
  DateTime startTime,
  DateTime endTime,
  Color? color,
  EventTypeLabel typeLabel,
});

class TodayEventSource extends CalendarDataSource<TodayEvent> {
  TodayEventSource(List<TodayEvent> appointments) {
    this.appointments = appointments;
  }
  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime as DateTime;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime as DateTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject as String;
  }

  @override
  TodayEvent convertAppointmentToObject(
    TodayEvent customData,
    Appointment appointment,
  ) {
    return (
      subject: appointment.subject,
      startTime: appointment.startTime,
      endTime: appointment.endTime,
      color: customData.color,
      typeLabel: customData.typeLabel,
    );
  }
}

class TodayTimeline extends StatefulWidget {
  const TodayTimeline({
    required this.events,
    this.onEventTap,
    required this.onEventUpdate,
    super.key,
  });

  final List<TodayEvent> events;
  final ValueChanged<TodayEvent>? onEventTap;
  final void Function(TodayEvent event, DateTime newStart, DateTime newEnd)
      onEventUpdate;

  @override
  State<TodayTimeline> createState() => _TodaysBlueprintState();
}

class _TodaysBlueprintState extends State<TodayTimeline>
    with AutomaticKeepAliveClientMixin {
  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  final GlobalKey _globalKey = GlobalKey();
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Theme(
      /// The key set here to maintain the state,
      ///  when we change the parent of the widget
      key: _globalKey,
      data: Theme.of(context),
      child: _getDragAndDropCalendar(
        _calendarController,
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SfCalendar(
      controller: calendarController,
      dataSource: TodayEventSource(
        widget.events,
      ),
      allowDragAndDrop: true,
      allowAppointmentResize: true,
      appointmentTextStyle: textTheme.bodyMedium!,
      todayTextStyle: textTheme.titleLarge?.copyWith(
        color: switch (theme.colorScheme.brightness) {
          Brightness.light => Colors.white,
          Brightness.dark => Colors.black,
        },
      ),
      blackoutDatesTextStyle: textTheme.bodyMedium,
      headerStyle: CalendarHeaderStyle(
        textStyle: textTheme.titleLarge,
      ),
      viewHeaderStyle: ViewHeaderStyle(
        dayTextStyle: textTheme.labelLarge,
        dateTextStyle: textTheme.labelLarge,
      ),
      headerHeight: 80,
      onTap: (calendarTapDetails) async {
        if (calendarTapDetails.targetElement == CalendarElement.appointment) {
          final appointment = calendarTapDetails.appointments?.first;
          if (appointment is! TodayEvent) {
            return;
          }

          widget.onEventTap?.call(appointment);
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

        if (appointment is! TodayEvent) {
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

        widget.onEventUpdate(appointment, newStartTime, newEndTime);
      },

      onAppointmentResizeEnd: (appointmentResizeEndDetails) {
        final appointment = appointmentResizeEndDetails.appointment;
        if (appointment is! TodayEvent) {
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

        widget.onEventUpdate(
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
        if (appointment is! TodayEvent) {
          return const SizedBox();
        }

        final isAfter = appointment.endTime.isAfter(now);
        final originalColor =
            appointment.color ?? Theme.of(context).colorScheme.surface;

        final startTime = Jiffy.parseFromDateTime(appointment.startTime)
            .format(pattern: 'hh:mm');
        final endTime = Jiffy.parseFromDateTime(appointment.endTime).format(
          pattern: 'hh:mm a',
        );

        final title = appointment.subject;
        final subtitle = '${startTime} to ${endTime}';
        return Card(
          margin: EdgeInsets.zero,
          color: originalColor,
          child: EventListTile(
            leading: appointment.typeLabel,
            title: title,
            subtitle: subtitle,
          ),
        );

        // return appointment.map(
        //   event: (appointment) => GeneralCalendarEventTile(
        //     appointment: appointment,
        //     isSmallVersion: appointment.endTime
        //             .difference(appointment.startTime)
        //             .inMinutes <=
        //         30,
        //     color: isAfter ? originalColor : originalColor?.withOpacity(0.5),
        //   ),
        //   task: (appointment) => TaskEventTile(
        //     appointment: appointment,
        //     color: isAfter ? originalColor : originalColor?.withOpacity(0.5),
        //   ),
        // );
      },
      timeSlotViewSettings: TimeSlotViewSettings(
        timeTextStyle: textTheme.labelMedium,
        minimumAppointmentDuration: const Duration(minutes: 15),
        timeIntervalHeight: 100,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
