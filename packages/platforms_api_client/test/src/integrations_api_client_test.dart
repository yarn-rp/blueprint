// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platforms_api_client/platforms_api_client.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('IntegrationsApiClient', () {
    late FirebaseFirestore firestore;

    late IntegrationsApiClient subject;

    setUp(() {
      firestore = FakeFirebaseFirestore();

      subject = IntegrationsApiClient(
        firestore: firestore,
      );
    });

    test('can be instantiated', () {
      expect(subject, isNotNull);
    });

    group('getPlatforms', () {
      test('returns a stream of platforms', () async {
        final platforms = [
          (
            id: 'id',
            name: 'displayName',
            iconUrl: 'iconUrl',
            type: 'task',
            description: null,
            auth: (
              type: 'type',
              url: 'url',
            ),
          ),
        ];

        for (final platform in platforms) {
          await firestore
              .collection('platforms')
              .withConverter(
                fromFirestore: platformConverter.fromFirestore,
                toFirestore: platformConverter.toFirestore,
              )
              .doc(platform.id)
              .set(platform);
        }

        final result = subject.getPlatforms();

        expect(result, emits(platforms));
      });
    });
  });
}
