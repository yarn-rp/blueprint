import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:integrations_repository/src/entities/entities.dart';
import 'package:rxdart/rxdart.dart';

const _platformsCollectionName = 'platforms';
const _authenticatorsCollectionName = 'authenticators';
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
    required Stream<String?> currentUserIdStream,
  }) {
    _currentUserIdStream = BehaviorSubject<String?>();
    currentUserIdStream.listen((event) {
      _currentUserIdStream.add(event);
    });
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
  late final BehaviorSubject<String?> _currentUserIdStream;

  late final FirebaseFunctions _firebaseFunctions;

  Stream<Iterable<Platform>>? _platformsSubscription;

  Stream<Iterable<Authenticator>> getAuthenticators() {
    final platformsStream = getAllPlatforms();

    return platformsStream.switchMap((platforms) {
      if (_currentUserIdStream.value == null) {
        return Stream.value([]);
      }

      final userAuthenticators = _usersCollection
          .doc(_currentUserIdStream.value)
          .collection(_authenticatorsCollectionName)
          .snapshots();

      return userAuthenticators.map((event) {
        return event.docs.map((e) {
          final data = {...e.data(), 'id': e.id};
          final platformId = data['platformName'];

          final platform = platforms.firstWhereOrNull(
            (element) => element.id == platformId,
          );
          return Authenticator.fromJson(
            {
              ...data,
              if (platform != null) 'platform': platform.toJson(),
            },
          );
        });
      });
    });
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

  Future<void> deleteAuthenticator(Authenticator authenticator) async {
    final userId = _currentUserIdStream.value;

    if (userId == null) {
      throw Exception('User not logged in');
    }

    await _usersCollection
        .doc(userId)
        .collection(_authenticatorsCollectionName)
        .doc(authenticator.id)
        .delete();
  }
}
