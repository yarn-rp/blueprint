import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:integrations_api_client/src/models/models.dart';

/// {@template integrations_api_client}
/// Client for the integrations API using Firestore.
/// {@endtemplate}
class IntegrationsApiClient {
  /// {@macro integrations_api_client}
  IntegrationsApiClient({
    required Stream<String?> idTokenStream,
    required FirebaseFirestore firestore,
    required FirebaseFunctions firebaseFunctions,
  })  : _firebaseFunctions = firebaseFunctions,
        _platformsCollection = firestore.collection('platforms').withConverter(
              fromFirestore: platformConverter.fromFirestore,
              toFirestore: platformConverter.toFirestore,
            ) {
    _idTokenSubscription = idTokenStream.listen((idToken) {
      _idToken = idToken;
    });
  }

  late final CollectionReference<PlatformModel> _platformsCollection;

  late final FirebaseFunctions _firebaseFunctions;
  late final StreamSubscription<String?> _idTokenSubscription;
  String? _idToken;

  /// Dispose of resources used by this client.
  Future<void> dispose() async {
    await _idTokenSubscription.cancel();
  }

  /// Streams all the platforms from Firestore.
  Stream<List<PlatformModel>> getPlatforms() => _platformsCollection
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  // /// Calls the connect API to connect an integration with the given params
  // Future<void> connectAuthenticator(Map<String, dynamic> params) async {
  //   try {
  //     final callable =
  //         _firebaseFunctions.httpsCallable('authenticators-connect');

  //     await callable<void>(
  //       params,
  //     );
  //   } on FirebaseFunctionsException catch (exception) {
  //     log(
  //       'Error while connecting integration: ${exception.message}',
  //       name: 'IntegrationsRepository',
  //     );
  //     rethrow;
  //   } catch (exception) {
  //     log(
  //       'Error while connecting integration: $exception',
  //       name: 'IntegrationsRepository',
  //     );
  //     rethrow;
  //   }
  // }

  // /// Streams all the authenticators the user has connected
  // Stream<List<AuthenticatorModel>> getConnectedAuthenticators() {
  //   final snap = _platformsCollection
  //       .doc(_idToken)
  //       .collection('authenticators')
  //       .snapshots();

  //   return snap.map((event) {
  //     final docsData = event.docs.map((e) => {...e.data(), 'id': e.id});

  //     return docsData.map(
  //       (data) {
  //         return (
  //           id: data['id'] as String,
  //           platformName: data['platformName'] as String,
  //           type: data['type'] as String,
  //           user: (
  //             email: data['user']['email'] as String,
  //             name: data['user']['name'] as String,
  //           ),
  //         );
  //       },
  //     ).toList();
  //   });
  // }

  // /// Deletes an integration from the database
  // Future<void> removeAuthenticator(
  //   String authenticatorId,
  // ) =>
  //     _platformsCollection
  //         .doc(_idToken)
  //         .collection('authenticators')
  //         .doc(authenticatorId)
  //         .delete();
}
