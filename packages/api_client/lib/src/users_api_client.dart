import 'dart:async';
import 'dart:developer';

import 'package:api_client/src/collections/collections.dart';
import 'package:api_client/src/functions/functions.dart';
import 'package:api_client/src/models/blueprint.dart';
import 'package:api_client/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

/// {@template api_client}
/// Client for the user API.
/// {@endtemplate}
class UsersApiClient {
  /// {@macro api_client}
  UsersApiClient({
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
      );
      rethrow;
    } catch (exception) {
      log(
        'Error while connecting integration: $exception',
      );
      rethrow;
    }
  }

  /// Streams all the authenticators the user has connected
  Stream<List<AuthenticatorModel>> getConnectedAuthenticators() {
    final snap = _usersCollection
        .doc(_idToken)
        .collection(Collections.authenticators)
        .withConverter(
          fromFirestore: authenticatorConverter.fromFirestore,
          toFirestore: authenticatorConverter.toFirestore,
        )
        .snapshots();

    return snap.map((event) => event.docs.map((e) => e.data()).toList());
  }

  /// Streams the blueprint of the user
  Stream<List<BlueprintItem>> getBlueprint() {
    final snap = _usersCollection
        .doc(_idToken)
        .collection(Collections.blueprint)
        .withConverter(
          fromFirestore: blueprintConverter.fromFirestore,
          toFirestore: blueprintConverter.toFirestore,
        )
        .snapshots();

    return snap.map((event) => event.docs.map((e) => e.data()).toList());
  }

  // Stream<List<TaskModel>> getAllTask() {
  //   final snap = _usersCollection
  //       .doc(_idToken)
  //       .collection(Collections.tasks)
  //       .where('type', isEqualTo: 'task')
  //       .withConverter(
  //         fromFirestore: taskConverter.fromFirestore,
  //         toFirestore: taskConverter.toFirestore,
  //       )
  //       .snapshots();

  //   return snap.map((event) => event.docs.map((e) => e.data()).toList());
  // }

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
