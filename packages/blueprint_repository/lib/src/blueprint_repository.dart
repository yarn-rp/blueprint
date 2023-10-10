import 'entities/entities.dart';

/// {@template blueprint_repository}
/// Repository to handle blueprints on the platform.
/// {@endtemplate}
class TodaysBlueprintRepository {
  /// {@macro blueprint_repository}
  const TodaysBlueprintRepository();

  /// Streams the todays blueprint from database.
  Stream<List<CalendarEvent>> getBlueprint() {
    // TODO(yarnr-p): implement getBlueprint
    throw UnimplementedError();
  }

  /// Saves the todays blueprint to database
  Future<void> saveBlueprint(List<CalendarEvent> blueprint) {
    // TODO(yarnr-p): implement saveBlueprint
    throw UnimplementedError();
  }
}
