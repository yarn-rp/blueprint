import 'package:calendar_repository/calendar_repository.dart';
import 'package:google_calendar_service/src/entities/entities.dart';

/// {@template google_calendar_integration}
/// Implementation of [CalendarIntegration] using Google Calendar API.
/// {@endtemplate}
class GoogleCalendarIntegration
    extends CalendarIntegration<GoogleCalendarPlatform> {
  /// {@macro google_calendar_integration}
  const GoogleCalendarIntegration(super.platform);

  @override
  List<Object?> get props => throw UnimplementedError();
}
