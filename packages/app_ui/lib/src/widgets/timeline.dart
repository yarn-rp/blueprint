// ignore_for_file: avoid_dynamic_calls

import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const double timeDensityUnit = 40;

enum TimeDensity {
  low(timeDensityUnit * 2),
  medium(timeDensityUnit * 3),
  high(timeDensityUnit * 4);

  const TimeDensity(this.value);

  final double value;
}

enum VerticalDirection {
  up,
  down,
}

class TodayTimeline extends StatefulWidget {
  const TodayTimeline({
    required this.events,
    this.timeDensity = TimeDensity.medium,
    this.onEventTap,
    this.createEventDialogBuilder,
    super.key,
  });

  final List<TodayEvent> events;

  // Widget to build using a PortalTarget
  final Widget Function(
    BuildContext context,
    TodayEvent event,
    VoidCallback closeDialog,
  )? createEventDialogBuilder;
  final ValueChanged<TodayEvent>? onEventTap;

  final TimeDensity timeDensity;

  @override
  State<TodayTimeline> createState() => _TodaysBlueprintState();
}

class _TodaysBlueprintState extends State<TodayTimeline>
    with AutomaticKeepAliveClientMixin {
  /// Controller used to control the calendar view
  late final CalendarController _calendarController;

  /// Temporary data on the event
  TemporaryEventData? temporaryEvent;

  /// Refers to the minimum duration you can move in the timeline.
  late int dragUnit;

  /// Refers to the visibility of the create event dialog.
  late TimeDensity selectedDensity;

  @override
  void initState() {
    dragUnit = 5;
    selectedDensity = widget.timeDensity;

    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        CalendarControls(
          calendarController: _calendarController,
          selectedDensity: selectedDensity,
          onDensityChange: (value) {
            setState(() {
              selectedDensity = value;
            });
          },
        ),
        Expanded(
          child: SfCalendar(
            controller: _calendarController,
            dataSource: TodayEventSource(widget.events),
            viewNavigationMode: ViewNavigationMode.none,
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
              backgroundColor: Colors.transparent,
            ),
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: textTheme.labelLarge,
              dateTextStyle: textTheme.labelLarge,
            ),
            headerHeight: 80,
            headerDateFormat: 'MMMM EEEE d',
            onTap: (calendarTapDetails) async {
              if (calendarTapDetails.targetElement ==
                  CalendarElement.appointment) {
                final appointment = calendarTapDetails.appointments?.first;
                if (appointment is! TodayEvent) {
                  return;
                }

                widget.onEventTap?.call(appointment);
              }
            },
            appointmentBuilder: (
              BuildContext context,
              CalendarAppointmentDetails calendarAppointmentDetails,
            ) {
              final appointment = calendarAppointmentDetails.appointments.last;
              if (appointment is! TodayEvent) {
                return const SizedBox();
              }

              final appointmentTile = AppointmentTile(
                appointment: appointment,
              );

              return appointmentTile;
            },
            timeSlotViewSettings: TimeSlotViewSettings(
              timeTextStyle: textTheme.labelMedium,
              minimumAppointmentDuration: const Duration(minutes: 15),
              timeIntervalHeight: selectedDensity.value,
            ),
            todayHighlightColor: theme.colorScheme.tertiary,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///
class CalendarControls extends StatelessWidget {
  const CalendarControls({
    super.key,
    required this.calendarController,
    required this.selectedDensity,
    required this.onDensityChange,
  });

  final CalendarController calendarController;
  final TimeDensity selectedDensity;
  final ValueChanged<TimeDensity> onDensityChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Date Navigation and Range Picker

        IconButton.filledTonal(
          color: Colors.red,
          icon: const Text('T'),
          onPressed: () {
            calendarController.displayDate = DateTime.now();
          },
        ),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            calendarController.backward?.call();
          },
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            calendarController.forward?.call();
            // Handle next month navigation
          },
        ),
        DropdownButton<CalendarView>(
          value: calendarController.view ?? CalendarView.day,
          items: [CalendarView.day, CalendarView.week, CalendarView.workWeek]
              .map(
                (e) => DropdownMenuItem<CalendarView>(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: (CalendarView? newValue) {
            if (newValue == null) {
              return;
            }
            calendarController.view = newValue;
          },
        ),
        DropdownButton<TimeDensity>(
          value: selectedDensity,
          items: TimeDensity.values
              .map(
                (e) => DropdownMenuItem<TimeDensity>(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }

            onDensityChange(value);
          },
        ),
      ],
    );
  }
}

class EditableTimeline extends StatefulWidget {
  const EditableTimeline({
    required this.events,
    required this.onEventUpdate,
    required this.newEventTemporaryName,
    this.intervalHeight = 180,
    this.onEventTap,
    this.createEventDialogBuilder,
    super.key,
  });

  final List<TodayEvent> events;

  final String newEventTemporaryName;

  // Widget to build using a PortalTarget
  final Widget Function(
    BuildContext context,
    TodayEvent event,
    VoidCallback closeDialog,
  )? createEventDialogBuilder;
  final ValueChanged<TodayEvent>? onEventTap;
  final void Function(TodayEvent event, DateTime newStart, DateTime newEnd)
      onEventUpdate;

  final double intervalHeight;

  @override
  State<EditableTimeline> createState() => _EditableTimelineState();
}

class _EditableTimelineState extends State<EditableTimeline>
    with AutomaticKeepAliveClientMixin {
  /// Controller used to control the calendar view
  late final CalendarController _calendarController;

  /// Temporary data on the event
  TemporaryEventData? temporaryEvent;

  /// Refers to the minimum duration you can move in the timeline.
  late int dragUnit;

  /// Refers to the height of the unit in the timeline.
  late double unitHeight;

  /// Refers to the visibility of the create event dialog.
  late bool _isCreateEventDialogVisible;

  TodayEvent? _selectedEvent;

  @override
  void initState() {
    dragUnit = 5;
    unitHeight = widget.intervalHeight / 60;
    _isCreateEventDialogVisible = false;
    _calendarController = CalendarController();
    super.initState();
  }

  void togglePortal() {
    setState(() {
      _isCreateEventDialogVisible = !_isCreateEventDialogVisible;
    });
  }

  void hidePortal() {
    setState(() {
      _isCreateEventDialogVisible = false;

      temporaryEvent = null;
    });
  }

  /// Returns the date at the offset position. If the calendar details provided
  /// by the controller is null, it will return the last appointment's start
  /// time.
  DateTime? _getCalendarStartDateTimeAtOffset(Offset localPosition) {
    final calendarDetails =
        _calendarController.getCalendarDetailsAtOffset?.call(localPosition);

    // Call to getCalendarDetailsAtOffset might return date as null when
    // there are already appointments for that slot. In that case, we can
    // use the last appointment's start time as the date.
    return calendarDetails?.date ??
        (calendarDetails?.appointments?.last as TodayEvent?)?.startTime;
  }

  void _onTemporaryEventDragStart(Offset localPosition) {
    final originalDate = _getCalendarStartDateTimeAtOffset(
      localPosition,
    );

    if (originalDate == null) {
      return;
    }

    var startingHourDetails = (
      date: originalDate,
      localPosition: localPosition,
    );

    // Adjust the loop to increment by unitHeight
    while (startingHourDetails.date == originalDate) {
      final roundedCalendarDetailsDate = _getCalendarStartDateTimeAtOffset(
        Offset(localPosition.dx, startingHourDetails.localPosition.dy),
      );

      if (roundedCalendarDetailsDate == null) {
        break;
      }

      startingHourDetails = (
        date: roundedCalendarDetailsDate,
        localPosition: Offset(
          localPosition.dx,
          startingHourDetails.localPosition.dy + unitHeight,
        ),
      );
    }

    // Calculate the current offset in minutes
    final currentOffset = localPosition.dy;

    final currentOffsetInMinutes =
        (startingHourDetails.localPosition.dy - currentOffset).abs() /
            unitHeight;

    // Adjust the current date by subtracting the calculated minutes
    final currentDate = startingHourDetails.date.subtract(
      Duration(
        minutes: currentOffsetInMinutes.toInt(),
      ),
    );

    final tmpEvent = (
      startTime: currentDate.truncate(minutes: dragUnit),
      startOffset: localPosition.dy,
      endTime: currentDate,
      endOffset: localPosition.dy,
    );

    setState(() {
      temporaryEvent = tmpEvent;
    });
  }

  /// Updates the temporary event taking into account the direction of the
  /// drag.
  void _updateTemporaryEventWithDirection(
    Offset localPosition,
    VerticalDirection direction,
  ) {
    if (temporaryEvent == null) {
      return;
    }
    final startTime = temporaryEvent!.startTime;
    final endTime = temporaryEvent!.endTime;

    final spaceSizeInMinutes =
        (temporaryEvent!.startOffset - localPosition.dy).abs() / unitHeight;

    final spaceDuration = Duration(minutes: spaceSizeInMinutes.toInt());

    switch (temporaryEvent) {
      case (null):
        break;
      case (final tEvent)
          when tEvent.startTime.isAtSameMomentAs(tEvent.endTime):
        final (st, so, et, eo) = switch (direction) {
          VerticalDirection.up => (
              startTime.subtract(
                Duration(
                  minutes: spaceSizeInMinutes.toInt(),
                ),
              ),
              localPosition.dy,
              endTime,
              temporaryEvent!.endOffset,
            ),
          VerticalDirection.down => (
              startTime,
              temporaryEvent!.startOffset,
              endTime.add(
                Duration(
                  minutes: spaceSizeInMinutes.toInt(),
                ),
              ),
              localPosition.dy,
            )
        };

        setState(() {
          temporaryEvent = (
            startTime: st,
            startOffset: so,
            endTime: et,
            endOffset: eo,
          );
        });
      case (final tEvent) when tEvent.startOffset >= localPosition.dy:
        setState(() {
          temporaryEvent = (
            startTime: startTime.subtract(spaceDuration),
            startOffset: localPosition.dy,
            endTime: endTime,
            endOffset: temporaryEvent!.endOffset,
          );
        });
      case (final tEvent) when tEvent.startOffset < localPosition.dy:
        setState(() {
          temporaryEvent = (
            startTime: startTime,
            startOffset: temporaryEvent!.startOffset,
            endTime: startTime.add(spaceDuration),
            endOffset: localPosition.dy,
          );
        });
    }
  }

  void _onTemporaryEventDragUpdate(
    DragUpdateDetails details,
  ) {
    final localPosition = details.localPosition;
    final direction =
        details.delta.dy > 0 ? VerticalDirection.down : VerticalDirection.up;

    // using the details of the screen and the calendarController, find out
    // at what time the user started creating the event.
    final date = _getCalendarStartDateTimeAtOffset(localPosition);

    if (date == null) {
      return;
    }

    _updateTemporaryEventWithDirection(localPosition, direction);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        CalendarControls(
          calendarController: _calendarController,
          selectedDensity: TimeDensity.medium,
          onDensityChange: (value) {},
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
              onVerticalDragStart: _selectedEvent != null
                  ? null
                  : (details) =>
                      _onTemporaryEventDragStart(details.localPosition),
              onVerticalDragUpdate: _onTemporaryEventDragUpdate,
              onVerticalDragEnd: (details) async {
                if (temporaryEvent == null) {
                  return;
                }

                setState(() {
                  _isCreateEventDialogVisible = true;
                });
              },
              child: SfCalendar(
                controller: _calendarController,
                dataSource: TodayEventSource([
                  if (temporaryEvent != null)
                    (
                      id: 'temporary',
                      subject: widget.newEventTemporaryName,
                      startTime: temporaryEvent!.startTime,
                      endTime: temporaryEvent!.endTime,
                      color: theme.colorScheme.secondary,
                      type: EventType.task,
                      isPreview: true,
                    ),
                  ...widget.events,
                ]),
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
                  backgroundColor: Colors.transparent,
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: textTheme.labelLarge,
                  dateTextStyle: textTheme.labelLarge,
                ),
                headerHeight: 80,
                onTap: (calendarTapDetails) async {
                  if (calendarTapDetails.targetElement ==
                      CalendarElement.appointment) {
                    final appointment = calendarTapDetails.appointments?.first;
                    if (appointment is! TodayEvent) {
                      return;
                    }

                    setState(() {
                      _selectedEvent = appointment;
                    });
                    widget.onEventTap?.call(appointment);
                    return;
                  }

                  setState(() {
                    _selectedEvent = null;
                  });
                },

                onDragUpdate: (AppointmentDragUpdateDetails details) {
                  final appointment = details.appointment;

                  if (appointment is! TodayEvent) {
                    return;
                  }
                },
                onDragStart: (AppointmentDragStartDetails details) {
                  final appointment = details.appointment;

                  if (appointment is! TodayEvent) {
                    return;
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

                  widget.onEventUpdate(
                    appointment,
                    startTime.copyWith(
                      minute: (startTime.minute / dragUnit).round() * dragUnit,
                    ),
                    endTime.copyWith(
                      minute: (endTime.minute / dragUnit).round() * dragUnit,
                    ),
                  );
                },
                onAppointmentResizeEnd: (appointmentResizeEndDetails) {
                  final appointment = appointmentResizeEndDetails.appointment;
                  if (appointment is! TodayEvent) {
                    return;
                  }

                  final startTime = appointment.startTime;
                  final endTime = appointment.endTime;

                  widget.onEventUpdate(
                    appointment,
                    startTime.copyWith(
                      minute: (startTime.minute / dragUnit).round() * dragUnit,
                    ),
                    endTime.copyWith(
                      minute: (endTime.minute / dragUnit).round() * dragUnit,
                    ),
                  );
                },

                appointmentBuilder: (
                  BuildContext context,
                  CalendarAppointmentDetails calendarAppointmentDetails,
                ) {
                  final appointment =
                      calendarAppointmentDetails.appointments.last;
                  if (appointment is! TodayEvent) {
                    return const SizedBox();
                  }

                  final isTemporaryEvent =
                      appointment.startTime == temporaryEvent?.startTime &&
                          appointment.endTime == temporaryEvent?.endTime &&
                          _isCreateEventDialogVisible;

                  final appointmentTile = AppointmentTile(
                    appointment: (
                      id: appointment.id,
                      color: appointment.color,
                      subject: appointment.subject,
                      type: appointment.type,
                      startTime: appointment.startTime.round(minutes: dragUnit),
                      endTime: appointment.endTime.round(minutes: dragUnit),
                      isPreview: appointment.isPreview,
                    ),
                    color: appointment.color,
                  );

                  if (!isTemporaryEvent) {
                    return appointmentTile;
                  }

                  return PortalTarget(
                    fit: StackFit.expand,
                    visible: _isCreateEventDialogVisible,
                    closeDuration: kThemeAnimationDuration,
                    portalFollower: Stack(
                      children: [
                        Barrier(
                          visible: _isCreateEventDialogVisible,
                          onClose: hidePortal,
                        ),
                        Builder(
                          builder: (context) {
                            return Positioned(
                              left: constraints.maxWidth / 5,
                              top: min(constraints.maxHeight / 5, 0),
                              width: constraints.maxWidth,
                              height: max(constraints.maxHeight / 5, 200) * 3,
                              child: TweenAnimationBuilder<double>(
                                duration: kThemeAnimationDuration,
                                curve: Curves.easeOut,
                                tween: Tween(
                                  begin: 0,
                                  end: _isCreateEventDialogVisible ? 1 : 0,
                                ),
                                builder: (context, opacity, _) => Opacity(
                                  opacity: opacity,
                                  child: SizedBox(
                                    height: constraints.maxHeight / 5 * 3,
                                    width: constraints.maxWidth,
                                    child:
                                        widget.createEventDialogBuilder?.call(
                                              context,
                                              appointment,
                                              hidePortal,
                                            ) ??
                                            const SizedBox(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    child: appointmentTile,
                  );
                },
                timeSlotViewSettings: TimeSlotViewSettings(
                  timeTextStyle: textTheme.labelMedium,
                  minimumAppointmentDuration: const Duration(minutes: 15),
                  timeIntervalHeight: widget.intervalHeight,
                ),
                todayHighlightColor: theme.colorScheme.tertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

typedef TemporaryEventData = ({
  DateTime startTime,
  double startOffset,
  DateTime endTime,
  double endOffset,
});

enum EventType {
  calendar,
  meeting,
  task,
}

typedef TodayEvent = ({
  String id,
  String subject,
  DateTime startTime,
  DateTime endTime,
  Color? color,
  EventType type,
  bool isPreview,
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
      id: customData.id,
      subject: appointment.subject,
      startTime: appointment.startTime,
      endTime: appointment.endTime,
      color: customData.color,
      type: customData.type,
      isPreview: customData.isPreview,
    );
  }
}
