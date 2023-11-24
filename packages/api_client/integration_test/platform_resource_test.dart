// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:api_client/src/models/models.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helper/helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const jiraPlatformId = 'jira';
  const githubPlatformId = 'github';
  const googleCalendarPlatformId = 'google-calendar';

  group('PlatformResource', () {
    late FirebaseFirestore firestore;
    late PlatformResource platformsApiClient;

    Future<void> setupTestDependencies(
      WidgetTester tester,
    ) async {
      final config = await tester.initFirebaseDependencies();

      firestore = config.firestore;
      platformsApiClient = PlatformResource(
        firestore: firestore,
      );
    }

    group('getPlatforms', () {
      testWidgets('streams a non empty list of platforms', (tester) async {
        await setupTestDependencies(tester);

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

      testWidgets('streams a list containing the jira platform',
          (tester) async {
        await setupTestDependencies(tester);

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.any(
                (platform) => platform.id == jiraPlatformId,
              ),
              'platforms contains jira',
              isTrue,
            ),
          ),
        );
      });

      testWidgets('streams a list containing the github platform',
          (tester) async {
        await setupTestDependencies(tester);

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.any(
                (platform) => platform.id == githubPlatformId,
              ),
              'platforms contains github',
              isTrue,
            ),
          ),
        );
      });

      testWidgets('streams a list containing the google-calendar platform',
          (tester) async {
        await setupTestDependencies(tester);

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.any(
                (platform) => platform.id == googleCalendarPlatformId,
              ),
              'platforms contains gitlab',
              isTrue,
            ),
          ),
        );
      });
    });
  });
}
