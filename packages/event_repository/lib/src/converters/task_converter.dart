import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_repository/src/entities/entities.dart';

/// {@template event_converter}
/// Converts a [DocumentSnapshot] to a [Event] and vice versa.
/// {@endtemplate}
abstract class EventConverter {
  /// Converts a [DocumentSnapshot] to a [Event].
  static Event fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    final data = snapshot.data()!;
    return Event.fromJson(data);
  }

  /// Converts a [Event] to a [Map].
  static Map<String, dynamic> toFirestore(Event event, SetOptions? _) =>
      event.toJson();
}
