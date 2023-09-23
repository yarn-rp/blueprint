import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:integrations_repository/src/entities/entities.dart';

const _platformsCollectionName = 'platforms';

const _usersCollectionName = 'users';

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    required FirebaseFirestore firestore,
    required FirebaseFunctions firebaseFunctions,
  }) {
    _firebaseFunctions = firebaseFunctions;

    _platformsCollection =
        firestore.collection(_platformsCollectionName).withConverter(
              fromFirestore: (snapshot, _) {
                try {
                  final data = snapshot.data()!;
                  print('data: $data');
                  return Platform.fromJson(data);
                } catch (e) {
                  print('Error parsing platform: $e');
                  rethrow;
                }
              },
              toFirestore: (platform, _) => platform.toJson(),
            );
  }

  /// The platforms collection reference.
  late final CollectionReference<Platform> _platformsCollection;

  late final FirebaseFunctions _firebaseFunctions;

  /// Returns a stream of all integrations from all repositories.
  Stream<Iterable<Platform>> getAllPlatforms() {
    print('Fething all platforms');
    final snaps = _platformsCollection.snapshots();
    print('snaps: $snaps');
    return snaps.map((event) => event.docs.map((e) => e.data()));
  }

  /// Adds a new [integration] to the repository.
  Future<void> addIntegration(Integration integration) async {
    try {
      print('Adding integration to firebase functions');

      final callable =
          _firebaseFunctions.httpsCallable('authenticators-connect');
      final params = integration.toConnectApiParams();
      print('params: $params');

      await callable<void>(
        params,
      );
      print('Integration added to firebase functions');
    } on FirebaseFunctionsException catch (exception) {
      print(
        'Error adding integration to firebase functions: ${exception.code} ${exception.message} ${exception.details}',
      );
    } catch (exception) {
      print(exception);
    }
  }

  /// Deletes an [integration] from the repository.
  Future<void> deleteIntegration(Integration integration) async {}
}
