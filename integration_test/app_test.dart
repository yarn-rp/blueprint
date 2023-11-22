// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:api_client/src/collections/collections.dart';
import 'package:api_client/src/models/models.dart';
import 'package:blueprint/core/firebase_options/firebase_options_dev.dart';
import 'package:blueprint/core/module/firebase_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// void main() {
//   final IntegrationTestWidgetsFlutterBinding binding =
//       IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets("Tapping on floating action button and verify counter",
//       (tester) async {
//     app.main();
//     await tester.pumpAndSettle();

//     expect(find.text('0'), findsOneWidget);

//     final Finder fab = find.byTooltip("fab");

//     await tester.tap(fab);

//     await tester.pumpAndSettle();

//     expect(find.text("1"), findsOneWidget);
//   });
// }

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

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PlatformApiClient', () {
    late FirebaseFirestore firestore;
    late FirebaseFunctions functions;
    late FirebaseAuth auth;

    late PlatformsApiClient platformsApiClient;

    Future<void> setupEmulators() async {
      final (firebaseAuth, firebaseFirestore, firebaseFunctions) =
          await initFirebaseDependencies();
      auth = firebaseAuth;
      firestore = firebaseFirestore;
      functions = firebaseFunctions;

      platformsApiClient = PlatformsApiClient(
        firestore: firestore,
      );
    }

    group('getPlatforms', () {
      testWidgets('streams a non empty stream of platforms', (tester) async {
        await setupEmulators();

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.isNotEmpty,
              'platforms is not empty',
              isTrue,
            ),
          ),
        );
      });
    });
  });
}
