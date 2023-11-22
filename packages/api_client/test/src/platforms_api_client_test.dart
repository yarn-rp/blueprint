// // ignore_for_file: prefer_const_constructors

// import 'package:api_client/api_client.dart';
// import 'package:api_client/src/collections/collections.dart';
// import 'package:api_client/src/models/models.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

// import './helper/helper.dart';

// void main() {
//   final IntegrationTestWidgetsFlutterBinding binding =
//       IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('PlatformApiClient', () {
//     late FirebaseFirestore firestore;
//     late FirebaseFunctions functions;
//     late FirebaseAuth auth;

//     late PlatformsApiClient platformsApiClient;

//     Future<void> setupEmulators() async {
//       final (firebaseAuth, firebaseFirestore, firebaseFunctions) =
//           await initFirebase();
//       auth = firebaseAuth;
//       firestore = firebaseFirestore;
//       functions = firebaseFunctions;

//       platformsApiClient = PlatformsApiClient(
//         firestore: firestore,
//       );
//     }

//     group('getPlatforms', () {
//       testWidgets('streams a list of platforms', (tester) async {
//         await setupEmulators();

//         final result = platformsApiClient.getPlatforms();

//         expect(
//           result,
//           isA<Stream<List<PlatformModel>>>(),
//         );
//       });

//       // });
//       // test('streams a list of platforms', () {
//       //   final result = platformsApiClient.getPlatforms();

//       //   expect(
//       //     result,
//       //     isA<Stream<List<PlatformModel>>>(),
//       //   );
//       // });

//       // test('streams the platforms available on firebase', () {
//       //   final result = platformsApiClient.getPlatforms();

//       //   expect(
//       //     result,
//       //     emits(<PlatformModel>[
//       //       (
//       //         id: 'jira',
//       //         name: 'jira',
//       //         iconUrl:
//       //             'https://static00.iconduck.com/assets.00/jira-icon-512x512-kkpo6eik.png',
//       //         type: 'task',
//       //         description: '',
//       //         auth: (
//       //           type: 'oauth2',
//       //           url:
//       //               'https://auth.atlassian.com/authorize?audience=api.atlassian.com&client_id=8ohszwsNEctmq9la0H4QrmfVlg03work%2Oread-jira-user%2Owrite-jira-work%2Omanage-jira-webhook&redirect_uri=https://polletask-dev.web.app/integrations/jira/create&state=120384019238401923840129',
//       //         )
//       //       ),
//       //     ]),
//       //   );
//       // });
//     });
//   });
// }
