import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:integrations_repository/src/entities/entities.dart';

const _platformsCollectionName = 'platforms';

const _usersCollectionName = 'users';

/// A converter for the [Platform] entity.
final platformConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return Platform.fromJson(data);
  },
  toFirestore: (Platform platform, _) => platform.toJson(),
);

/// {@template integrations_repository}
/// Repository in charge of handling integrations in the blueprint platform.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    required FirebaseFirestore firestore,
    required FirebaseFunctions firebaseFunctions,
    required this.currentUserIdStream,
  }) {
    _firebaseFunctions = firebaseFunctions;
    _usersCollection = firestore.collection(_usersCollectionName);
    _platformsCollection =
        firestore.collection(_platformsCollectionName).withConverter(
              fromFirestore: platformConverter.fromFirestore,
              toFirestore: platformConverter.toFirestore,
            );
  }

  /// The platforms collection reference.
  late final CollectionReference<Platform> _platformsCollection;
  // ignore: unused_field
  late final CollectionReference _usersCollection;

  /// Stream of the current user id.
  final Stream<String?> currentUserIdStream;

  late final FirebaseFunctions _firebaseFunctions;

  Stream<Iterable<Platform>>? _platformsSubscription;

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<Iterable<Integration>> getAllIntegrations() {
    return Stream.value([]);
  }

  /// Returns a stream of all integrations from all repositories.
  Stream<Iterable<Platform>> getAllPlatforms() {
    if (_platformsSubscription == null) {
      final snaps = _platformsCollection.snapshots();
      _platformsSubscription = snaps.map(
        (event) => event.docs.map((e) => e.data()),
      );
    }
    return _platformsSubscription!;
  }

  Future<void> integrateWithPlatform(
    String platformId,
    Map<String, dynamic> params,
  ) async {
    final platforms = await getAllPlatforms().first;

    final platform = platforms.firstWhere(
      (element) => element.id == platformId,
      orElse: () => throw Exception('Platform not found'),
    );

    return switch ((platform.authentication, params)) {
      (OAuth2(), {'code': final String code}) => _addIntegration(
          OAuth2Integration(
            platform,
            code,
          ),
        ),
      (
        Basic(),
        {'username': final String username, 'password': final String password}
      ) =>
        _addIntegration(BasicIntegration(platform, username, password)),
      _ => throw Exception('Invalid params'),
    };
  }

  /// Adds a new [integration] to the repository.
  Future<void> _addIntegration(Integration integration) async {
    try {
      final callable =
          _firebaseFunctions.httpsCallable('authenticators-connect');
      final params = integration.toConnectApiParams();

      await callable<void>(
        params,
      );
    } on FirebaseFunctionsException catch (exception) {
      log(
        'Error while connecting integration: ${exception.message}',
        name: 'IntegrationsRepository',
      );
      rethrow;
    } catch (exception) {
      log(
        'Error while connecting integration: $exception',
        name: 'IntegrationsRepository',
      );
      rethrow;
    }
  }

  /// Deletes an [integration] from the repository.
  Future<void> deleteIntegration(Integration integration) async {}
}
