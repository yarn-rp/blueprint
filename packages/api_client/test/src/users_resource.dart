// ignore_for_file: prefer_const_constructors
import 'package:api_client/api_client.dart';
import 'package:api_client/src/collections/collections.dart';
import 'package:api_client/src/functions/functions.dart';
import 'package:api_client/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class _MockHttpsCallable extends Mock implements HttpsCallable {}

class _MockHttpsCallableResult<T> extends Mock
    implements HttpsCallableResult<T> {}

void main() {
  group('UserResource', () {
    late UserResource userResource;
    late FirebaseFirestore firestore;
    late FirebaseFunctions firebaseFunctions;

    test('can be instantiated', () {
      firestore = FakeFirebaseFirestore();
      firebaseFunctions = _MockFirebaseFunctions();
      userResource = UserResource(
        firestore: firestore,
        firebaseFunctions: firebaseFunctions,
        idTokenStream: Stream.value(''),
      );

      expect(
        userResource,
        isNotNull,
      );
    });

    group('connect-authenticator', () {
      const userId = 'some-id';
      late HttpsCallable callable;

      setUp(() {
        firestore = FakeFirebaseFirestore();
        firebaseFunctions = _MockFirebaseFunctions();
        userResource = UserResource(
          firestore: firestore,
          firebaseFunctions: firebaseFunctions,
          idTokenStream: Stream.value(userId),
        );

        callable = _MockHttpsCallable();
        // ignore: inference_failure_on_function_invocation
        when(() => callable.call<void>(any())).thenAnswer(
          (_) async => _MockHttpsCallableResult(),
        );
        when(
          () => firebaseFunctions.httpsCallable(Functions.connectAuthenticator),
        ).thenReturn(callable);
      });

      test('calls the connectAuthenticator function', () async {
        final params = <String, dynamic>{};
        await userResource.connectAuthenticator(params);

        verify(
          () => firebaseFunctions.httpsCallable(
            Functions.connectAuthenticator,
          ),
        ).called(1);

        verify(() => callable.call<void>(params)).called(1);
      });

      test('throws exception when function throws exception', () {
        final exception = Exception('oops');
        final params = <String, dynamic>{};
        when(() => callable.call<void>(params)).thenThrow(exception);

        expect(
          () => userResource.connectAuthenticator(params),
          throwsA(
            exception,
          ),
        );

        verify(
          () => firebaseFunctions.httpsCallable(
            Functions.connectAuthenticator,
          ),
        ).called(1);

        verify(() => callable.call<void>(params)).called(1);
      });
    });

    group('removeAuthenticator', () {
      const userId = 'some-id';

      setUp(() {
        firestore = FakeFirebaseFirestore();
        firebaseFunctions = _MockFirebaseFunctions();
        userResource = UserResource(
          firestore: firestore,
          firebaseFunctions: firebaseFunctions,
          idTokenStream: Stream.value(userId),
        );
      });

      test('removes the authenticator from the user', () async {
        const authenticator = (
          id: 'some-id',
          platformName: 'github',
          type: 'task',
          user: (
            email: 'some@email.com',
            name: 'Yan Rodriguez',
          ),
        );

        await firestore
            .collection(Collections.users)
            .doc(userId)
            .collection(Collections.authenticators)
            .withConverter(
              fromFirestore: authenticatorConverter.fromFirestore,
              toFirestore: authenticatorConverter.toFirestore,
            )
            .doc(authenticator.id)
            .set(authenticator);

        await userResource.removeAuthenticator(authenticator.id);

        final authenticatorDoc = await firestore
            .collection(Collections.users)
            .doc(userId)
            .collection(Collections.authenticators)
            .doc(authenticator.id)
            .get();

        expect(
          authenticatorDoc.exists,
          isFalse,
        );
      });

      test('throws exception if document does not exists', () {
        expect(
          () => userResource.removeAuthenticator('non-existent-id'),
          throwsA(
            isA<Exception>(),
          ),
        );
      });
    });

    group('getConnectedAuthenticators', () {
      const userId = 'some-id';

      setUp(() {
        firestore = FakeFirebaseFirestore();
        firebaseFunctions = _MockFirebaseFunctions();
        userResource = UserResource(
          firestore: firestore,
          firebaseFunctions: firebaseFunctions,
          idTokenStream: Stream.value(userId),
        );
      });

      test(
        'streams snapshot of the authenticators user has under '
        'authenticators sub-collection',
        () {
          const authenticator = (
            id: 'some-id',
            platformName: 'github',
            type: 'task',
            user: (
              email: 'some@email.com',
              name: 'Yan Rodriguez',
            ),
          );

          firestore
              .collection(Collections.users)
              .doc(userId)
              .collection(Collections.authenticators)
              .withConverter(
                fromFirestore: authenticatorConverter.fromFirestore,
                toFirestore: authenticatorConverter.toFirestore,
              )
              .doc('some-id')
              .set(authenticator);

          final stream = userResource.getConnectedAuthenticators();

          expect(
            stream,
            emits(
              [
                authenticator,
              ],
            ),
          );
        },
      );

      test('emits empty list if user has no authenticators', () {
        final stream = userResource.getConnectedAuthenticators();

        expect(
          stream,
          emits(
            [],
          ),
        );
      });
    });
  });
}
