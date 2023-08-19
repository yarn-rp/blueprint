import 'package:local_integrations_repository/local_integrations_repository.dart';

/// {@template calendar_platform}
/// Platform which manages calendar events.
/// {@endtemplate}
abstract class CalendarPlatform extends Platform {
  /// {@macro calendar_platform}
  const CalendarPlatform({
    required super.id,
    required super.displayName,
    required super.iconUrl,
  });
}
