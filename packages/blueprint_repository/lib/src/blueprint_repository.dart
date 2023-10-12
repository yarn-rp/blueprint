import 'package:blueprint_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';

const _usersCollectionName = 'users';

/// {@template blueprint_repository}
/// Repository to handle blueprints on the platform.
/// {@endtemplate}
class TodaysBlueprintRepository {
  /// {@macro blueprint_repository}
  TodaysBlueprintRepository({
    required Stream<String?> currentUserIdStream,
    required FirebaseFirestore firestore,
  }) {
    _currentUserIdStream = currentUserIdStream;
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  late final Stream<String?> _currentUserIdStream;

  late final CollectionReference _usersCollection;

  /// Streams the user blueprint from database.
  Stream<List<CalendarEvent>> getBlueprint() {
    return _currentUserIdStream.switchMap<List<CalendarEvent>>((userId) {
      if (userId == null) {
        return const Stream.empty();
      }

      final userDoc = _usersCollection.doc(userId);

      return userDoc.snapshots().map((snapshot) {
        final userData = snapshot.data() as Map<String, dynamic>?;
        final blueprint =
            userData?['blueprint'] as List<Map<String, dynamic>>? ?? [];

        return blueprint.map<CalendarEvent>(CalendarEvent.fromJson).toList();
      });
    });
  }

  /// Saves the todays blueprint to database
  Future<void> saveBlueprints(List<CalendarEvent> blueprint) async {
    final userId = await _currentUserIdStream.last;
    final userData = _usersCollection.doc(userId);

    await userData.set({
      'blueprint': blueprint.map((e) => e.toJson()).toList(),
    });
  }
}
