import 'package:blueprint_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_repository/task_repository.dart';

const _usersCollectionName = 'users';
const _blueprintCollectionName = 'blueprint';

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
  Stream<List<BlueprintItem>> getBlueprint() {
    return _currentUserIdStream.switchMap<List<BlueprintItem>>((userId) {
      if (userId == null) {
        return const Stream.empty();
      }

      final userDoc = _usersCollection.doc(userId);
      final blueprintSubCollection =
          userDoc.collection(_blueprintCollectionName);
      return blueprintSubCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          try {
            final data = doc.data();
            final item = BlueprintItem.fromJson(data);
            print('Got item: $item');

            return item;
          } catch (error, stackTrace) {
            print('Got error while parsing blueprint item: $error $stackTrace');
            rethrow;
          }
        }).toList();
      });
    });
  }

  Future<void> addBlueprintItem({
    required Task task,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final userId = _currentUserIdStream.value;
    if (userId == null) {
      return;
    }

    final userDoc = _usersCollection.doc(userId);
    final blueprintSubCollection = userDoc.collection(_blueprintCollectionName);
    final doc = blueprintSubCollection.doc();

    final blueprintEvent = BlueprintItem.task(
      value: task,
      id: doc.id,
      startTime: startTime,
      endTime: endTime,
    );

    await doc.set(blueprintEvent.toJson());
  }

  Future<void> updateBlueprintItem(BlueprintItem event) async {
    final userId = _currentUserIdStream.value;
    if (userId == null) {
      return;
    }
    final userDoc = _usersCollection.doc(userId);
    final blueprintSubCollection = userDoc.collection(_blueprintCollectionName);

    final eventDoc = blueprintSubCollection.doc(event.id);
    await eventDoc.update(event.toJson());
  }

  Future<void> deleteBlueprintItem(BlueprintItem event) async {
    final userId = _currentUserIdStream.value;
    if (userId == null) {
      return;
    }
    final userDoc = _usersCollection.doc(userId);
    final blueprintSubCollection = userDoc.collection(_blueprintCollectionName);

    final eventDoc = blueprintSubCollection.doc(event.id);
    await eventDoc.delete();
  }
}
