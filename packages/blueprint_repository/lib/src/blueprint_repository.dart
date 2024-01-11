import 'package:blueprint_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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
    _currentUserIdStream = BehaviorSubject<String?>();
    currentUserIdStream.listen((event) {
      _currentUserIdStream.add(event);
    });
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  late final BehaviorSubject<String?> _currentUserIdStream;

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
        return blueprint
            .map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    });
  }

  /// Saves the todays blueprint of the current user
  Future<void> saveBlueprint(List<CalendarEvent> blueprint) async {
    final userId = _currentUserIdStream.value;
    if (userId == null) {
      return;
    }
    final userDoc = _usersCollection.doc(userId);

    final blueprintsJson = blueprint.map((e) => e.toJson()).toList();
    await userDoc.update({
      'blueprint': blueprintsJson,
    });
  }
}
