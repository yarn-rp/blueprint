import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dev_access/firebase_access.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

typedef EmulatorsConfigData = ({
  FirebaseAuth auth,
  FirebaseFirestore firestore,
  FirebaseFunctions functions
});

extension FirebaseEmulatorsTesterX on WidgetTester {
  /// Initializes Firebase and sets up the emulators for testing.
  /// Returns a tuple of [FirebaseAuth], [FirebaseFirestore] and
  /// [FirebaseFunctions] to avoid side effects
  Future<EmulatorsConfigData> initFirebaseDependencies() async {
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

    return (
      auth: firebaseAuth,
      firestore: firebaseFirestore,
      functions: firebaseFunctions,
    );
  }
}
