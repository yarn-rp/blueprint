import 'package:blueprint_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generative_ai_dart/generative_ai_dart.dart';
import 'package:integrations_repository/integrations_repository.dart';
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
    required GenerativeModel generativeModel,
    required this.platformsStream,
  }) {
    _generativeModel = generativeModel;
    _currentUserIdStream = BehaviorSubject<String?>();
    currentUserIdStream.listen((event) {
      _currentUserIdStream.add(event);
    });
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  late final BehaviorSubject<String?> _currentUserIdStream;

  late final CollectionReference _usersCollection;

  late final GenerativeModel _generativeModel;

  /// Stream of all platforms.
  final Stream<Iterable<Platform>> platformsStream;

  final BehaviorSubject<List<BlueprintItem>> _blueprintStream =
      BehaviorSubject<List<BlueprintItem>>();

  /// Generates a blueprint for today using the AI model. This doesn't save the
  /// blueprint to the database, instead returns the suggested blueprint so the
  /// user can review and save it.
  ///
  /// This will take the current blueprint and modify it to fit the user's
  /// schedule or prompt.
  Future<List<BlueprintItem>> generateAIBlueprint(
    String userPrompt,
    List<Task> userTasks,
  ) async {
    final currentBlueprint = _blueprintStream.value;

    final blueprintSerialized =
        currentBlueprint.map((e) => e.toJson()).toList();

    final generateAIReponse = await _generativeModel.generateContent([
      Content.user([
        Part.text(
          'Help me create a schedule for today. Please keep the events'
          ' time. We are going to fill the remaining time slots with tasks. '
          'Also respect the tasks already in the schedule. Include some text '
          'explaining why you chose the tasks and events.',
        ),
      ]),
    ]);

    print('The response I got is: ${generateAIReponse}');

    return currentBlueprint;
  }

  /// Return a stream of the current user blueprints.
  Stream<List<BlueprintItem>> getBlueprint() {
    if (_blueprintStream.hasValue) {
      return _blueprintStream.stream;
    }

    final blueprintLatestStream =
        _currentUserIdStream.switchMap<List<BlueprintItem>>((userId) {
      if (userId == null) {
        return const Stream.empty();
      }

      final userDoc = _usersCollection.doc(userId);
      final blueprintSubCollection =
          userDoc.collection(_blueprintCollectionName);
      return platformsStream.switchMap((platforms) {
        return blueprintSubCollection.snapshots().map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            final blueprintItem = BlueprintItem.fromJson(data);

            final platform = platforms.firstWhere(
              (element) =>
                  element.id ==
                  blueprintItem.map(
                    event: (event) => event.value.access.platformId,
                    task: (task) => task.value.access.platformId,
                  ),
            );

            return blueprintItem.map(
              event: (event) => event.copyWith(
                value: event.value.copyWith(
                  access: event.value.access.withPlatform(platform),
                ),
              ),
              task: (task) => task.copyWith(
                value: task.value.copyWith(
                  access: task.value.access.withPlatform(platform),
                ),
              ),
            );
          }).toList();
        });
      });
    });

    _blueprintStream.addStream(blueprintLatestStream);

    return _blueprintStream.stream;
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
