import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poll_e_task/blueprint/entities/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodaysBlueprint extends StatefulWidget {
  const TodaysBlueprint({
    super.key,
  });

  @override
  State<TodaysBlueprint> createState() => _TodaysBlueprintState();
}

class _TodaysBlueprintState extends State<TodaysBlueprint> {
  EventsDataSource _events = EventsDataSource(<CalendarEvent>[]);

  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  final GlobalKey _globalKey = GlobalKey();
  final ScrollController _controller = ScrollController();
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    _events = EventsDataSource([
      CalendarEvent(
        subject: 'Launch',
        startTime: DateTime.now().copyWith(
          hour: 13,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ),
        endTime: DateTime.now().copyWith(
          hour: 14,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ),
      ),
    ]);
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
        _events,
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
  SfCalendar _getDragAndDropCalendar([
    CalendarController? calendarController,
    CalendarDataSource? calendarDataSource,
  ]) {
    final now = DateTime.now();

    return SfCalendar(
      controller: calendarController,
      dataSource: calendarDataSource,
      allowDragAndDrop: true,
      minDate: now.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
      maxDate: now.copyWith(
        hour: 23,
        minute: 59,
        second: 59,
        millisecond: 999,
      ),

      onTap: (calendarTapDetails) {
        if (calendarTapDetails.targetElement == CalendarElement.appointment) {
          final appointment =
              calendarTapDetails.appointments?.first as CalendarEvent;
          print(appointment.subject);
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
        final appointment = details.appointment as CalendarEvent?;
        if (appointment == null) {
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

        setState(() {
          appointment
            ..startTime = newStartTime
            ..endTime = newEndTime;
        });
      },
      appointmentBuilder: (
        BuildContext context,
        CalendarAppointmentDetails calendarAppointmentDetails,
      ) {
        final appointment =
            calendarAppointmentDetails.appointments.first as CalendarEvent;

        return Container(
          decoration: BoxDecoration(
            color: appointment.color,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.cyan],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          alignment: Alignment.center,
          child: appointment.isAllDay
              ? Text(
                  appointment.subject,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appointment.subject,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${DateFormat('hh:mm a').format(appointment.startTime)} - '
                      '${DateFormat('hh:mm a').format(appointment.endTime)}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
        );
      },
      timeSlotViewSettings: const TimeSlotViewSettings(
        minimumAppointmentDuration: Duration(minutes: 15),
      ),
    );
  }
}

class EventsDataSource extends CalendarDataSource<CalendarEvent> {
  EventsDataSource(List<CalendarEvent> source) {
    appointments = source;
  }
}
