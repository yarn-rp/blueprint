import 'package:blueprint_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';

const _usersCollectionName = 'users';

/// {@template blueprint_repository}
/// Repository to handle blueprints on the platform.
/// {@endtemplate}
class BlueprintRepository {
  /// {@macro blueprint_repository}
  BlueprintRepository({
    required Stream<String?> currentUserIdStream,
    required FirebaseFirestore firestore,
  }) {
    _currentUserIdStream = currentUserIdStream;
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  late final Stream<String?> _currentUserIdStream;

  late final CollectionReference _usersCollection;

  /// Return a stream of the current user blueprints.
  Stream<List<CalendarEvent>> getBlueprint() {
    return _currentUserIdStream.switchMap<List<CalendarEvent>>((userId) {
      if (userId == null) {
        return const Stream.empty();
      }
      final userDoc = _usersCollection.doc(userId);
      return userDoc.snapshots().map((snapshot) {
        final userData = snapshot.data() as Map<String, dynamic>?;
        final blueprint = userData?['blueprint'] as List<dynamic>? ?? [];
        return blueprint.map((e) {
          if (e is! Map<String, dynamic>) {
            throw Exception('This is not a map');
          }
          return CalendarEvent.fromJson(e);
        }).toList();
      });
    });
  }

  /// Saves the todays blueprint of the current user
  Future<void> saveBlueprints(List<CalendarEvent> blueprint) async {
    final userId = await _currentUserIdStream.first;
    final userDoc = _usersCollection.doc(userId);
    final userData = (await userDoc.get()).data() as Map<String, dynamic>?;
    final blueprintsJson = blueprint.map((e) => e.toJson()).toList();
    await userDoc.set({
      ...?userData,
      'blueprint': blueprintsJson,
    });
  }
}
