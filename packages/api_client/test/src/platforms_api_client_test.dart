// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:api_client/src/collections/collections.dart';
import 'package:api_client/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformApiClient', () {
    late PlatformsApiClient platformsApiClient;
    late FirebaseFirestore firestore;

    test('can be instantiated', () {
      firestore = FakeFirebaseFirestore();
      platformsApiClient = PlatformsApiClient(firestore: firestore);
      expect(
        platformsApiClient,
        isNotNull,
      );
    });

    group('getPlatforms', () {
      final platforms = <PlatformModel>[
        (
          id: '1',
          name: 'Platform 1',
          iconUrl: 'https://platform1.com/logo.png',
          type: 'calendar',
          description: 'Platform 1 description',
          auth: (
            type: 'oauth2',
            url: 'https://platform1.com/auth',
          ),
        ),
        (
          id: '2',
          name: 'Platform 2',
          iconUrl: 'https://platform2.com/logo.png',
          type: 'task',
          description: 'Platform 2 description',
          auth: (
            type: 'oauth2',
            url: 'https://platform2.com/auth',
          ),
        ),
      ];

      setUp(() async {
        firestore = FakeFirebaseFirestore();
        platformsApiClient = PlatformsApiClient(firestore: firestore);

        await Future.wait(
          platforms.map(
            (platform) => firestore
                .collection(Collections.platforms)
                .withConverter(
                  fromFirestore: platformConverter.fromFirestore,
                  toFirestore: platformConverter.toFirestore,
                )
                .doc(platform.id)
                .set(platform),
          ),
        );
      });

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
          emits(
            platforms,
          ),
        );
      });
    });
  });
}
