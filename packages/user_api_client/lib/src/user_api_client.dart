import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:user_api_client/src/collections/collections.dart';
import 'package:user_api_client/src/functions/functions.dart';
import 'package:user_api_client/src/models/models.dart';

/// {@template user_api_client}
/// Client for the user API.
/// {@endtemplate}
class UserApiClient {
  /// {@macro user_api_client}
  UserApiClient({
    required Stream<String?> idTokenStream,
    required FirebaseFirestore firestore,
    required FirebaseFunctions firebaseFunctions,
  })  : _firebaseFunctions = firebaseFunctions,
        _usersCollection =
            firestore.collection(Collections.users).withConverter(
                  fromFirestore: userConverter.fromFirestore,
                  toFirestore: userConverter.toFirestore,
                ) {
    _idTokenSubscription = idTokenStream.listen((idToken) {
      _idToken = idToken;
    });
  }
  late final CollectionReference<UserModel> _usersCollection;
  late final FirebaseFunctions _firebaseFunctions;
  late final StreamSubscription<String?> _idTokenSubscription;
  String? _idToken;

  /// Dispose of resources used by this client.
  Future<void> dispose() async {
    await _idTokenSubscription.cancel();
  }

  /// Calls the connect API to connect an integration with the given params
  Future<void> connectAuthenticator(Map<String, dynamic> params) async {
    try {
      final callable =
          _firebaseFunctions.httpsCallable(Functions.connectAuthenticator);

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

  /// Streams all the authenticators the user has connected
  Stream<List<AuthenticatorModel>> getConnectedAuthenticators() {
    final snap = _usersCollection
        .doc(_idToken)
        .collection(Collections.authenticators)
        .snapshots();

    return snap.map((event) {
      final docsData = event.docs.map((e) => {...e.data(), 'id': e.id});

      return docsData.map(
        (data) {
          final user = data['user'] as Map<String, dynamic>;

          return (
            id: data['id'] as String,
            platformName: data['platformName'] as String,
            type: data['type'] as String,
            user: (
              email: user['email'] as String,
              name: user['name'] as String,
            ),
          );
        },
      ).toList();
    });
  }

  /// Deletes an integration from the database
  Future<void> removeAuthenticator(
    String authenticatorId,
  ) =>
      _usersCollection
          .doc(_idToken)
          .collection(Collections.authenticators)
          .doc(authenticatorId)
          .delete();
}
