import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> initFirebase({
  FirebaseFirestore? firestore,
  FirebaseFunctions? functions,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  firestore ??= FirebaseFirestore.instance;
  functions ??= FirebaseFunctions.instance;

  firestore.useFirestoreEmulator('localhost', 8080);
  functions.useFunctionsEmulator('localhost', 5001);
}

/// Starts the Firebase emulator.
Future<void> startFirebaseEmulator() async {
  await Process.run(
    'yarn',
    [
      'serve:seed',
    ],
    // TODO(yarn-rp): change this to the root of the project when migrating
    // other repo to this one
    workingDirectory:
        '/Users/yanrodriguez/Documents/work/Blueprint/blueprint-firebase',
  );
}

/// Stops the Firebase emulator.
Future<void> stopFirebaseEmulator() async {
  await Process.run(
    'firebase',
    ['emulators:stop'],
  );
}
