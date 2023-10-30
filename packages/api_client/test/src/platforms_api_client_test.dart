// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:api_client/src/collections/collections.dart';
import 'package:api_client/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import './helper/helper.dart';

void main() {
  group('PlatformApiClient', () {
    late FirebaseFirestore firestore;
    late PlatformsApiClient platformsApiClient;

    setUpAll(() {
      firestore = FirebaseFirestore.instance;
      platformsApiClient = PlatformsApiClient(
        firestore: firestore,
      );

      // setupFirebaseForEmulators(
      //   firestore: firestore,
      // );
    });

    group('getPlatforms', () {
      test('streams a list of platforms', () {
        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          isA<Stream<List<PlatformModel>>>(),
        );
      });

      test('streams the platforms available on firebase', () {
        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(<PlatformModel>[
            (
              id: 'jira',
              name: 'jira',
              iconUrl:
                  'https://static00.iconduck.com/assets.00/jira-icon-512x512-kkpo6eik.png',
              type: 'task',
              description: '',
              auth: (
                type: 'oauth2',
                url:
                    'https://auth.atlassian.com/authorize?audience=api.atlassian.com&client_id=8ohszwsNEctmq9la0H4QrmfVlg03work%2Oread-jira-user%2Owrite-jira-work%2Omanage-jira-webhook&redirect_uri=https://polletask-dev.web.app/integrations/jira/create&state=120384019238401923840129',
              )
            ),
          ]),
        );
      });
    });
  });
}
