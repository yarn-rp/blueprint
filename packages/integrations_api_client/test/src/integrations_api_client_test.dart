// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integrations_api_client/integrations_api_client.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

void main() {
  group('IntegrationsApiClient', () {
    late FirebaseFirestore firestore;
    late FirebaseFunctions firebaseFunctions;
    late IntegrationsApiClient subject;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      firebaseFunctions = _MockFirebaseFunctions();

      subject = IntegrationsApiClient(
        idTokenStream: Stream.value(null),
        firestore: firestore,
        firebaseFunctions: firebaseFunctions,
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
