import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarSettings extends StatefulWidget {
  const CalendarSettings({
    required this.onCalendarViewChanged,
    required this.onTimeDensityChanged,
    required this.selectedCalendarView,
    required this.selectedTimeDensity,
    super.key,
  });

  final ValueChanged<CalendarView?> onCalendarViewChanged;
  final ValueChanged<TimeDensity?> onTimeDensityChanged;
  final CalendarView selectedCalendarView;
  final TimeDensity selectedTimeDensity;

  @override
  State<CalendarSettings> createState() => _CalendarSettingsState();
}

class _CalendarSettingsState extends State<CalendarSettings> {
  late bool _isVisible;
  late CalendarView _selectedCalendarView;

  @override
  void initState() {
    _isVisible = false;
    _selectedCalendarView = widget.selectedCalendarView;
    super.initState();
  }

  void togglePortal() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void hidePortal() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePortal,
      child: PortalTarget(
        visible: _isVisible,
        closeDuration: kThemeAnimationDuration,
        anchor: const Aligned(
          follower: Alignment.topRight,
          target: Alignment.topRight,
        ),
        portalFollower: Stack(
          alignment: Alignment.topRight,
          children: [
            Barrier(
              visible: _isVisible,
              onClose: hidePortal,
            ),
            Positioned(
              top: AppSpacing.xxxlg,
              right: AppSpacing.md,
              child: TweenAnimationBuilder<double>(
                duration: kThemeAnimationDuration,
                curve: Curves.easeOut,
                tween: Tween(begin: 0, end: _isVisible ? 1 : 0),
                builder: (context, opacity, _) => Opacity(
                  opacity: opacity,
                  child: _TimelineSettingsMenu(
                    onCalendarViewChanged: (calendarView) {
                      if (calendarView == null) return;
                      setState(() {
                        _selectedCalendarView = calendarView;
                      });
                      widget.onCalendarViewChanged(calendarView);
                    },
                    onTimeDensityChanged: widget.onTimeDensityChanged,
                    selectedCalendarView: _selectedCalendarView!,
                    selectedTimeDensity: widget.selectedTimeDensity,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: IconButton(
          onPressed: togglePortal,
          icon: const Icon(Icons.edit_calendar),
        ),
      ),
    );
  }
}

class _TimelineSettingsMenu extends StatelessWidget {
  const _TimelineSettingsMenu({
    required this.onCalendarViewChanged,
    required this.onTimeDensityChanged,
    required this.selectedCalendarView,
    required this.selectedTimeDensity,
  });

  final ValueChanged<CalendarView?> onCalendarViewChanged;
  final ValueChanged<TimeDensity?> onTimeDensityChanged;
  final CalendarView selectedCalendarView;
  final TimeDensity selectedTimeDensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 400,
      child: Material(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black,
        elevation: 14,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: theme.colorScheme.primary,
              ),
              title: Text('Calendar View'),
              subtitle: Text('Select the calendar view'),
            ),
            RadioListTile<CalendarView>(
              value: CalendarView.day,
              groupValue: selectedCalendarView,
              onChanged: onCalendarViewChanged,
              title: const Text('Day'),
            ),
            RadioListTile<CalendarView>(
              value: CalendarView.week,
              groupValue: selectedCalendarView,
              onChanged: onCalendarViewChanged,
              title: const Text('Week'),
            ),
            RadioListTile<CalendarView>(
              value: CalendarView.workWeek,
              groupValue: selectedCalendarView,
              onChanged: onCalendarViewChanged,
              title: const Text('Work Week'),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.timeline,
                color: theme.colorScheme.primary,
              ),
              title: Text('Time Density'),
              subtitle: Text('Select the time density'),
            ),
            RadioListTile<TimeDensity>(
              value: TimeDensity.low,
              groupValue: selectedTimeDensity,
              onChanged: onTimeDensityChanged,
              title: const Text('Low'),
            ),
            RadioListTile<TimeDensity>(
              value: TimeDensity.medium,
              groupValue: selectedTimeDensity,
              onChanged: onTimeDensityChanged,
              title: const Text('Medium'),
            ),
            RadioListTile<TimeDensity>(
              value: TimeDensity.high,
              groupValue: selectedTimeDensity,
              onChanged: onTimeDensityChanged,
              title: const Text('High'),
            ),
          ],
        ),
      ),
    );
  }
}
