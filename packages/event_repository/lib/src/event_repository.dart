import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_repository/src/converters/converters.dart';
import 'package:event_repository/src/entities/entities.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:stream_transform/stream_transform.dart';

const _platformsCollectionName = 'platforms';

const _usersCollectionName = 'users';

/// {@template calendar_repository}
/// Repository which manages events from the firestore collection
/// This repository can be used to manage multiple calendars of the same
/// platform, for example, multiple Google calendars.
/// {@endtemplate}
class EventRepository {
  /// {@macro calendar_repository}
  EventRepository({
    required FirebaseFirestore firestore,
    required this.currentUserIdStream,
  }) {
    _usersCollection = firestore.collection(_usersCollectionName);
    _platformsCollection =
        firestore.collection(_platformsCollectionName).withConverter(
              fromFirestore: PlatformConverter.fromFirestore,
              toFirestore: PlatformConverter.toFirestore,
            );
  }

  /// The platforms collection reference.
  late final CollectionReference<Platform> _platformsCollection;
  late final CollectionReference _usersCollection;

  /// Stream of the current user id.
  final Stream<String?> currentUserIdStream;

  /// Returns a stream of all events from all repositories.
  Stream<Iterable<Platform>> _getAllPlatforms() {
    final snaps = _platformsCollection.snapshots();
    return snaps.map((event) => event.docs.map((e) => e.data()));
  }

  /// Returns a stream of the events of the day for the current user.
  Stream<Iterable<Event>> getTodayEvents() =>
      currentUserIdStream.switchMap<Iterable<Event>>(
        (userId) {
          if (userId == null) {
            return const Stream.empty();
          }
          final userData = _usersCollection.doc(userId);
          // TODO: change this for plans when plan oriented DB is implemented
          final eventsSubCollection =
              userData.collection('events').withConverter<Event>(
                    fromFirestore: EventConverter.fromFirestore,
                    toFirestore: EventConverter.toFirestore,
                  );

          final platformsStream = _getAllPlatforms();

          return platformsStream.switchMap(
            (platforms) => eventsSubCollection.snapshots().map(
                  (events) => events.docs.map((event) {
                    final eventEntity = event.data();
                    return eventEntity;
                  }),
                ),
          );
        },
      );
}
