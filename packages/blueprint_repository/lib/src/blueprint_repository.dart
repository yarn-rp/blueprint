import 'dart:async';
import 'dart:convert';

import 'package:ai_client/ai_client.dart';
import 'package:blueprint_repository/src/entities/entities.dart';
import 'package:blueprint_repository/src/extension/date_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    required AiClient aiClient,
    required this.platformsStream,
  }) {
    _aiClient = aiClient;
    _currentUserIdStream = BehaviorSubject<String?>();
    currentUserIdStream.listen((event) {
      _currentUserIdStream.add(event);
    });
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  late final BehaviorSubject<String?> _currentUserIdStream;

  late final CollectionReference _usersCollection;

  late final AiClient _aiClient;

  /// Stream of all platforms.
  final Stream<Iterable<Platform>> platformsStream;

  final BehaviorSubject<List<BlueprintItem>> _blueprintStream =
      BehaviorSubject<List<BlueprintItem>>();

  FutureOr<Map<String, dynamic>> _buildAIBlueprintPromptMetadata(
    String userPrompt,
    List<Task> userTasks,
    List<BlueprintItem> currentBlueprint,
  ) {
    return {
      'blueprintItems': currentBlueprint
          .map(
            (e) => {
              'runtimeType': e.map(
                event: (event) => 'event',
                task: (task) => 'task',
              ),
              'startTime': e.startTime.toIso8601String(),
              'endTime': e.endTime.toIso8601String(),
              'value': e.map(
                event: (e) => {
                  'description': e.value.description,
                },
                task: (e) => {
                  'id': e.value.id,
                  'description': e.value.description,
                },
              ),
            },
          )
          .toList(),
      'tasks': userTasks
          .map(
            (e) => {
              'id': e.id,
              'description': e.description,
              'startTime': e.startDate?.toIso8601String(),
              'endTime': e.dueDate?.toIso8601String(),
              'additionalDetails': {
                'priority': e.priority,
                'labels': e.labels.map((e) => e.toJson()).toList(),
              },
            },
          )
          .toList(),
      'userPrompt': userPrompt,
      'todaysDate': DateTime.now().startOfDay.toIso8601String(),
    };
  }

  /// Generates a blueprint for today using the AI model. This doesn't save the
  /// blueprint to the database, instead returns the suggested blueprint so the
  /// user can review and save it.
  ///
  /// This will take the current blueprint and modify it to fit the user's
  /// schedule or prompt.
  Future<(List<BlueprintItem>, String)> generateAIBlueprint(
    String userPrompt,
    List<Task> userTasks,
  ) async {
    final currentBlueprint =
        _blueprintStream.hasValue ? _blueprintStream.value : <BlueprintItem>[];

    try {
      final generateAIResponse = await _aiClient.generateContentString(
        content: '',
        metadata: await _buildAIBlueprintPromptMetadata(
          userPrompt,
          userTasks,
          currentBlueprint
              .where(
                (element) => element.startTime.isAfter(
                  DateTime.now().startOfDay,
                ),
              )
              .toList(),
        ),
      );

      final decodedResponse =
          await jsonDecode(generateAIResponse) as Map<String, dynamic>;

      final items = (decodedResponse['items'] as List).map(
        (e) => _parseAIResponseItems(e as Map<String, dynamic>, userTasks),
      );

      final reason = decodedResponse['reason'] as String;

      return (items.toList(), reason);
    } catch (error, stackTrace) {
      return Error.throwWithStackTrace(
        error,
        stackTrace,
      );
    }
  }

  BlueprintItem _parseAIResponseItems(
    Map<String, dynamic> item,
    List<Task> userTasks,
  ) {
    final id = item['taskId'] as String;
    final startTime = DateTime.parse(item['startTime'] as String);
    final endTime = DateTime.parse(item['endTime'] as String);

    final task = userTasks.firstWhere(
      (element) => element.id == id,
    );

    return BlueprintItem.task(
      value: task,
      id: id,
      startTime: startTime,
      endTime: endTime,
    );
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
