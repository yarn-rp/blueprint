import 'dart:async';

import 'package:calendar_repository/calendar_repository.dart';
import 'package:google_calendar_service/src/entities/entities.dart';
import 'package:googleapis/calendar/v3.dart' as gCalendar;
import 'package:googleapis_auth/googleapis_auth.dart' as gApis;
import 'package:http/http.dart' as http;

/// {@template google_calendar_integration}
/// Implementation of [CalendarIntegration] using Google Calendar API.
/// {@endtemplate}
class GoogleCalendarIntegration
    extends CalendarIntegration<GoogleCalendarPlatform> {
  /// {@macro google_calendar_integration}
  GoogleCalendarIntegration(
    super.platform,
    this.oAuthTokenString,
    this.accountName,
  ) {
    _client.complete(authenticatedClient(oAuthTokenString));
  }

  /// OAuth token string.
  final String oAuthTokenString;

  /// The name of the authenticated user
  final String accountName;

  /// The authenticated client.
  final Completer<gApis.AuthClient?> _client = Completer<gApis.AuthClient>();

  /// The calendar API authenticated with the proper credentials to fetch user
  /// events.
  Future<gCalendar.CalendarApi> get calendarAPI =>
      _client.future.then((client) => gCalendar.CalendarApi(client!));

  @override
  List<Object?> get props => [
        platform,
        oAuthTokenString,
        accountName,
      ];
}

/// Retrieve a `gApis` authenticated client.
Future<gApis.AuthClient>? authenticatedClient(
  String authToken,
) async {
  final credentials = gApis.AccessCredentials(
    gApis.AccessToken(
      'Bearer',
      authToken,
      // TODO(kevmoo): Use the correct value once it's available from authentication
      // See https://github.com/flutter/flutter/issues/80905
      DateTime.now().toUtc().add(const Duration(days: 365)),
    ),
    null,
    [
      gCalendar.CalendarApi.calendarScope,
    ],
  );

  return gApis.authenticatedClient(http.Client(), credentials);
}
