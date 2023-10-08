
/// {@template google_calendar_platform}
/// Google Calendar platform.
/// {@endtemplate}
final class GoogleCalendarPlatform extends CalendarPlatform {
  const GoogleCalendarPlatform._()
      : super(
          id: 'google_calendar',
          displayName: 'Google Calendar',
          iconUrl:
              'https://www.gstatic.com/images/branding/product/1x/calendar_48dp.png',
        );

  /// {@macro google_calendar_platform}
  static const GoogleCalendarPlatform instance = GoogleCalendarPlatform._();
}
