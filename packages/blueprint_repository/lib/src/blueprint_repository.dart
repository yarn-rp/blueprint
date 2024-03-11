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

const _aiScheduleBlueprintTaskPrompt = '''
Given the following JSON input data:
BlueprintItems: An array of items already scheduled. Each item includes an identifier, type (event or task), description, start and end dates, and an object for any additional details.
Tasks: A list of tasks to be scheduled. Each task has an identifier, description, estimated duration, and an object for any additional details.
UserPrompt: A string capturing any specific instructions or requests from the user for this scheduling instance.
```
{
  "blueprintItems": [
    {
      "id": "string",
      "runtimeType": "event|task",
      "startTime": "timestamp",
      "endTime": "timestamp",
      "value": Task|Event,
    }
  ],
  "tasks": [
    {
      "id": "string",
      "description": "string",
      "estimatedDuration": "time",
      "additionalDetails": {}
    }
  ],
  "userPrompt": "string"
}
```
Generate a schedule that integrates the unscheduled tasks into the existing BlueprintItems, respecting the user's preferences and specific instructions. Leave all the existing BlueprintItems in place, and add the newly scheduled tasks to the output. When scheduling the tasks, analyze the task metadata to estimate which ones the user should focus the most on, and prioritize those tasks in the schedule. Data might not be available for all tasks, so when it comes to estimating the time, 
calculate the time based on what you think it should take you. If the user has not provided any specific instructions, use your best judgment to schedule the tasks in a way that makes sense.
Avoid collisions between tasks making sure we don't have multiple events or tasks scheduled at the same time. If there are any collisions, provide a rationale for the decision made to resolve the collision. If the user has provided specific instructions, make sure to follow them and provide a rationale for any decisions that deviate from the user's instructions.
Do not schedule tasks for the past. Only schedule tasks for the future. If the user has provided specific instructions, make sure to follow them and provide a rationale for any decisions that deviate from the user's instructions.

The output should be a JSON object with two main fields:
items: An array of Tasks, only containing the Tasks that we are going to include in the blueprint. This should contain only the taskId, startTime and endTime fields. The taskId should match the id provided in the input tasks array. The startTime and endTime are scheduled times you have chosen for the task.
reason: A text explanation detailing the logic behind how the tasks were selected and scheduled, with particular emphasis on adherence to the user's preferences and the specific instructions provided in the user prompt. If no specific instructions were provided, the rationale should explain the general approach taken to the scheduling.
The scheduling should optimize the placement of tasks, ensuring there are no overlaps and that all user-defined constraints are respected. The rationale should provide insights into the decision-making process, especially regarding any unique or complex scheduling choices made in response to the user's specific requests.
The reason is directed to the user and should be written in a conversational tone, as if it were a message from the AI to the user. 
```
{
  "items": [
    {
      "taskId": "string",
      "startTime": "timestamp",
      "endTime": "timestamp",
    }
  ],
  "reason": "string"
}
```
Next to this message you will find the data to be used as input for the AI model. Please use this data to generate the schedule.
Do not use any non alphanumeric character in the reason field.
''';

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
              'id': e.id,
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
                  'id': e.value.description,
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
        content: _aiScheduleBlueprintTaskPrompt,
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

      // Data is coming in the following format:
      // ```json
      // { ... }
      // ```
      // We need to get rid of the ```json and ``` and then parse the JSON.
      final jsonStart = generateAIResponse.indexOf('{');
      final jsonEnd = generateAIResponse.lastIndexOf('}');
      final generateAIResponseJson = generateAIResponse.substring(
        jsonStart,
        jsonEnd + 1,
      );

      final decodedResponse =
          await jsonDecode(generateAIResponseJson) as Map<String, dynamic>;

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
