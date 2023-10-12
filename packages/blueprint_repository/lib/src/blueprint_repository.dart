import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

import 'entities/entities.dart';

const _usersCollectionName = 'users';
final blueprintConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;

    ///Create the blueprint list,converting firestore data
    /// into CalendarEvent model and adding into the list
    final blueprints = <CalendarEvent>[];
    data.entries.forEach((element) => blueprints
        .add(CalendarEvent.fromJson(element as Map<String, dynamic>)));
    return blueprints;
  },
  toFirestore: (CalendarEvent event, SetOptions? options) => event.toJson(),
);

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

      ///fetch the current user data
      final userData = _usersCollection.doc(userId);
      final snapshot = userData.get();

      ///Parsing data to blueprints
      final blueprints = blueprintConverter.fromFirestore(
          snapshot as DocumentSnapshot<Map<String, dynamic>>,
          SnapshotOptions());

      ///Adding the blueprint list to the Stream then close the connection
      return Stream.value(blueprints);
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
