import 'package:calendar_repository/src/entities/entities.dart';
import 'package:integrations_repository/integrations_repository.dart';

/// {@template calendar_integration}
/// Integration with a calendar service.
/// {@endtemplate}
abstract class CalendarIntegration<
        CalendarPlatformType extends CalendarPlatform>
    extends Integration<CalendarPlatformType> {
  /// {@macro calendar_integration}
  const CalendarIntegration(super.platform);
}
