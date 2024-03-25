// ignore_for_file: avoid_dynamic_calls

import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

enum VerticalDirection {
  up,
  down,
}

class TodayTimeline extends StatefulWidget {
  const TodayTimeline({
    required this.events,
    this.intervalHeight = 180,
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

  final double intervalHeight;

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

  /// Refers to the height of the unit in the timeline.
  late double unitHeight;
  @override
  void initState() {
    dragUnit = 5;
    unitHeight = widget.intervalHeight / 60;

    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SfCalendar(
      controller: _calendarController,
      dataSource: TodayEventSource(widget.events),
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
        timeIntervalHeight: widget.intervalHeight,
      ),
      todayHighlightColor: theme.colorScheme.tertiary,
    );
  }

  @override
  bool get wantKeepAlive => true;
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

  void _onTemporaryEventDragStart(Offset localPosition) {
    final calendarDetails =
        _calendarController.getCalendarDetailsAtOffset?.call(
      Offset(localPosition.dx, localPosition.dy),
    );

    if (calendarDetails == null || calendarDetails.date == null) {
      return;
    }
    final originalDate = calendarDetails.date!;

    var startingHourDetails = (
      date: originalDate,
      localPosition: localPosition,
    );

    // Original Date can be 10:00, but the user can start creating the event
    // at 10:30 and the getCalendarDetailsAtOffset will return 10:00. So we
    // need to find out the exact time the user stated creating the event. For
    // that we are going to ask the calendarController to find out the time
    // at the current offset, resting the unitHeight, until we get a different
    // date.
    while (startingHourDetails.date == originalDate) {
      final roundedCalendarDetails =
          _calendarController.getCalendarDetailsAtOffset?.call(
        Offset(localPosition.dx, startingHourDetails.localPosition.dy),
      );

      if (roundedCalendarDetails == null ||
          roundedCalendarDetails.date == null) {
        break;
      }

      startingHourDetails = (
        date: roundedCalendarDetails.date!,
        localPosition:
            Offset(localPosition.dx, startingHourDetails.localPosition.dy + 1),
      );
    }

    // At this point, startingHourDetails.date will be have the real position
    // of the rounded hour, so we can calculate given the localPosition, the
    // time that corresponds to the current offset.
    final currentOffset = localPosition.dy;

    final currentOffsetInMinutes =
        (startingHourDetails.localPosition.dy - currentOffset).abs() /
            unitHeight;

    final currentDate = startingHourDetails.date.subtract(
      Duration(
        minutes: currentOffsetInMinutes.toInt(),
      ),
    );

    setState(() {
      temporaryEvent = (
        startTime: currentDate.truncate(minutes: dragUnit),
        startOffset: localPosition.dy,
        endTime: currentDate,
        endOffset: localPosition.dy,
      );
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
    final calendarDetails =
        _calendarController.getCalendarDetailsAtOffset?.call(
      Offset(localPosition.dx, localPosition.dy),
    );

    final date = calendarDetails?.date ??
        (calendarDetails?.appointments?.last as TodayEvent?)?.startTime;

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

    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onVerticalDragStart: _selectedEvent != null
            ? null
            : (details) => _onTemporaryEventDragStart(details.localPosition),
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
            final appointment = calendarAppointmentDetails.appointments.last;
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
                              child: widget.createEventDialogBuilder?.call(
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
