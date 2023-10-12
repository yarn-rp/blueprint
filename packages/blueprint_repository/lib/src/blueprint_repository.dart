import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';

import 'entities/entities.dart';

const _usersCollectionName = 'users';

/// {@template blueprint_repository}
/// Repository to handle blueprints on the platform.
/// {@endtemplate}
class TodaysBlueprintRepository {
  /// {@macro blueprint_repository}
  TodaysBlueprintRepository({
    required this.currentUserIdStream,
    required FirebaseFirestore firestore,
  }) {
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  /// Stream of the current user id.
  final Stream<String?> currentUserIdStream;

  ///User collection reference
  late final CollectionReference _usersCollection;

  /// Streams the todays blueprint from database.
  Stream<List<CalendarEvent>> getBlueprint() {
    return currentUserIdStream.switchMap<List<CalendarEvent>>((userId) {
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
    try {
      final userId = await currentUserIdStream.last;
      final userData = _usersCollection.doc(userId);
      await userData.set(blueprint);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
