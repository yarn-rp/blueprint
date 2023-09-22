import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_repository/src/entities/entities.dart';

/// {@template task_converter}
/// Converts a [DocumentSnapshot] to a [Task] and vice versa.
/// {@endtemplate}
abstract class TaskConverter {
  /// Converts a [DocumentSnapshot] to a [Task].
  static Task fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    final data = snapshot.data()!;
    return Task.fromJson(data);
  }

  /// Converts a [Task] to a [Map].
  static Map<String, dynamic> toFirestore(Task task, SetOptions? _) =>
      task.toJson();
}
