// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:api_client/src/models/models.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../helper/helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PlatformResource', () {
    late FirebaseFirestore firestore;
    late FirebaseFunctions functions;
    late FirebaseAuth auth;

    late PlatformResource platformsApiClient;

    setUp(() async {
      final (firebaseAuth, firebaseFirestore, firebaseFunctions) =
          await initFirebaseDependencies();
      auth = firebaseAuth;
      firestore = firebaseFirestore;
      functions = firebaseFunctions;

      platformsApiClient = PlatformResource(
        firestore: firestore,
      );
    });

    group('getPlatforms', () {
      testWidgets('streams a non empty stream of platforms', (tester) async {
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
