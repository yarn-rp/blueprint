// ignore_for_file: invalid_annotation_target

import 'package:blueprint/core/env/app_environment.dart';
import 'package:blueprint/core/firebase_options/firebase_options_dev.dart'
    as firebase_dev_options;
import 'package:blueprint/core/firebase_options/firebase_options_prd.dart'
    as firebase_prod_options;
import 'package:blueprint/core/firebase_options/firebase_options_stg.dart'
    as firebase_stg_options;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

/// Module in charge of declaring all injectable [Firebase] dependencies.
///
/// {@macro use_app_environment}
@module
abstract class FirebaseModule {
  /// {@template firebase_app}
  /// Initializes a firebase app with a given configuration.
  ///
  /// Is registered as a `singleton` and with the `preResolve` to
  /// pre-await the future and register it's resolved value.
  /// {@endtemplate}
  @singleton
  @preResolve
  Future<FirebaseApp> firebaseApp(
    FirebaseOptions firebaseOptions,
  ) async =>
      Firebase.initializeApp(
        options: firebaseOptions,
      );

  @singleton
  @local
  FirebaseOptions get localFirebaseOptions =>
      firebase_dev_options.DefaultFirebaseOptions.currentPlatform;

  @singleton
  @development
  FirebaseOptions get developmentFirebaseOptions =>
      firebase_dev_options.DefaultFirebaseOptions.currentPlatform;

  @singleton
  @production
  FirebaseOptions get productionFirebaseOptions =>
      firebase_prod_options.DefaultFirebaseOptions.currentPlatform;

  @singleton
  @staging
  FirebaseOptions get stagingFirebaseOptions =>
      firebase_stg_options.DefaultFirebaseOptions.currentPlatform;

  @lazySingleton
  FirebaseAuth firebaseAuth(FirebaseApp app) => FirebaseAuth.instanceFor(
        app: app,
      );

  @lazySingleton
  FirebaseFirestore firebaseFirestore(FirebaseApp app) =>
      FirebaseFirestore.instanceFor(
        app: app,
      );

  @lazySingleton
  FirebaseFunctions firebaseFunctions(FirebaseApp app) =>
      FirebaseFunctions.instanceFor(
        app: app,
      );
}

@local
@preResolve
Future<void> setupFirebaseEmulators(
  FirebaseAuth auth,
  FirebaseFirestore firestore,
  FirebaseFunctions functions,
) async {
  const emulatorsConfigString = String.fromEnvironment('emulators');
  if (emulatorsConfigString.isEmpty) {
    return Future.value();
  }
  final (:authAddress, :firestoreAddress, :functionsAddress) =
      _parseEmulatorsConfig(emulatorsConfigString);

  await auth.useAuthEmulator(authAddress.host, authAddress.port);
  firestore.useFirestoreEmulator(firestoreAddress.host, firestoreAddress.port);
  functions.useFunctionsEmulator(functionsAddress.host, functionsAddress.port);

  return Future.value();
}

EmulatorsConfig _parseEmulatorsConfig(String emulatorsConfigString) {
  // Remove all whitespace for easier parsing
  final compactConfig = emulatorsConfigString.replaceAll(RegExp(r'\s+'), '');

  // Extract key-value pairs using a regular expression
  final exp = RegExp(r'(\w+):{?([^\{\}]+)}?,?');
  final matches = exp.allMatches(compactConfig);

  final emulatorsConfig = <String, dynamic>{};
  for (final match in matches) {
    final group1 = match.group(1);
    final group2 = match.group(2);
    if (group1 == null || group2 == null) {
      continue;
    }
    // Nested structure
    if (group2.contains(':')) {
      final innerMatch = RegExp(r'(\w+):(\d+)').firstMatch(group2);
      final innerGroup1 = innerMatch?.group(1);
      final innerGroup2 = innerMatch?.group(2);

      if (innerGroup1 == null || innerGroup2 == null) {
        continue;
      }

      if (innerMatch != null) {
        final innerMap = <String, int>{};
        innerMap[innerGroup1] = int.parse(innerGroup2);

        emulatorsConfig[group1] = innerMap;
      }
    } else {
      emulatorsConfig[group1] = group2;
    }
  }

  final authAddress = _parseAddress(emulatorsConfig['auth']);
  final firestoreAddress = _parseAddress(emulatorsConfig['firestore']);
  final functionsAddress = _parseAddress(emulatorsConfig['functions']);

  return (
    authAddress: authAddress,
    firestoreAddress: firestoreAddress,
    functionsAddress: functionsAddress,
  );
}

Address _parseAddress(dynamic address) {
  if (address is Map) {
    return (
      host: 'localhost',
      port: address['port'],
    );
  }
  // Handle other cases or throw an error
  throw const FormatException('Invalid address format');
}

typedef EmulatorsConfig = ({
  Address authAddress,
  Address firestoreAddress,
  Address functionsAddress,
});

typedef Address = ({
  String host,
  int port,
});
