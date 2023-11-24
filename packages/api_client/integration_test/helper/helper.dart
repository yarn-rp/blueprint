import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dev_access/firebase_access.dart';
import 'package:flutter/widgets.dart';

Future<(FirebaseAuth, FirebaseFirestore, FirebaseFunctions)>
    initFirebaseDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
  final firebaseFirestore = FirebaseFirestore.instanceFor(app: firebaseApp);
  final firebaseFunctions = FirebaseFunctions.instanceFor(app: firebaseApp);

  await setupFirebaseEmulators(
    firebaseAuth,
    firebaseFirestore,
    firebaseFunctions,
  );

  return (firebaseAuth, firebaseFirestore, firebaseFunctions);
}
