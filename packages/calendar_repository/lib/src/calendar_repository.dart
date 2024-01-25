import 'package:calendar_repository/src/entities/access/access.dart';
import 'package:calendar_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:stream_transform/stream_transform.dart';

const _usersCollectionName = 'users';

/// Event converter for firestore.
final eventConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return Event.fromJson(data);
  },
  toFirestore: (Event event, SetOptions? options) => event.toJson(),
);

/// {@template calendar_repository}
/// Repository which manages calendar events of the same Type.
/// This repository can be used to manage multiple calendars of the same
/// platform, for example, multiple Google calendars.
/// {@endtemplate}
class CalendarRepository {
  /// {@macro calendar_repository}
  CalendarRepository({
    required FirebaseFirestore firestore,
    required this.platformsStream,
    required this.currentUserIdStream,
  }) {
    _usersCollection = firestore.collection(_usersCollectionName);
  }

  late final CollectionReference _usersCollection;

  /// Stream of the current user id.
  final Stream<String?> currentUserIdStream;

  /// Stream of all platforms.
  final Stream<Iterable<Platform>> platformsStream;

  Stream<Iterable<Event>> getEvents() {
    return currentUserIdStream.switchMap((userId) {
      if (userId == null) {
        return const Stream.empty();
      }
      final userData = _usersCollection.doc(userId);
      final eventsSubCollection = userData.collection('events');

      return platformsStream.switchMap(
        (platforms) => eventsSubCollection.snapshots().map((event) {
          return event.docs.map((e) {
            final data = e.data();
            final access = Access.fromJson(
              data['access'] as Map<String, dynamic>,
            );
            final platformId = access.platformId;

            final eventPlatform = platforms.firstWhere(
              (element) => platformId == element.id,
            );

            final eventEntity = Event.fromJson(data);

            return eventEntity.copyWith(
              access: access.withPlatform(eventPlatform),
            );
          });
        }),
      );
    });
  }
}
