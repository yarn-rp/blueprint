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
