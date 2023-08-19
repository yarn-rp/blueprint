import 'package:calendar_repository/calendar_repository.dart';
import 'package:google_calendar_service/google_calendar_service.dart';

/// {@template google_calendar_integration_mapper}
/// Mapper for [GoogleCalendarIntegration].
/// {@endtemplate}
class GoogleCalendarIntegrationMapper
    implements
        PlatformIntegrationMapper<GoogleCalendarPlatform,
            GoogleCalendarIntegration> {
  @override
  GoogleCalendarIntegration fromJson(Map<String, dynamic> json) {
    return GoogleCalendarIntegration(
      GoogleCalendarPlatform.instance,
      json['oAuthTokenString'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson(GoogleCalendarIntegration integration) => {
        'oAuthTokenString': integration.oAuthTokenString,
      };
}
