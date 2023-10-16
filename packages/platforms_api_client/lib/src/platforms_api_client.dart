import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platforms_api_client/src/models/models.dart';

/// {@template platforms_api_client}
/// Client for the integrations API using Firestore.
/// {@endtemplate}
class IntegrationsApiClient {
  /// {@macro platforms_api_client}
  IntegrationsApiClient({
    required FirebaseFirestore firestore,
  }) : _platformsCollection = firestore.collection('platforms').withConverter(
              fromFirestore: platformConverter.fromFirestore,
              toFirestore: platformConverter.toFirestore,
            );

  late final CollectionReference<PlatformModel> _platformsCollection;

  /// Streams all the platforms from Firestore.
  Stream<List<PlatformModel>> getPlatforms() => _platformsCollection
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}
