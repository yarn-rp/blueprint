// ignore_for_file: prefer_const_constructors
import 'package:api_client/api_client.dart';
import 'package:api_client/src/functions/functions.dart';
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
  group('UsersApiClient', () {
    late UsersApiClient usersApiClient;
    late FirebaseFirestore firestore;
    late FirebaseFunctions firebaseFunctions;

    test('can be instantiated', () {
      firestore = FakeFirebaseFirestore();
      firebaseFunctions = _MockFirebaseFunctions();
      usersApiClient = UsersApiClient(
        firestore: firestore,
        firebaseFunctions: firebaseFunctions,
        idTokenStream: Stream.value(''),
      );

      expect(
        usersApiClient,
        isNotNull,
      );
    });

    group('connect-authenticator', () {
      late HttpsCallable callable;
      setUp(() {
        firestore = FakeFirebaseFirestore();
        firebaseFunctions = _MockFirebaseFunctions();
        usersApiClient = UsersApiClient(
          firestore: firestore,
          firebaseFunctions: firebaseFunctions,
          idTokenStream: Stream.value(''),
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
        await usersApiClient.connectAuthenticator(params);

        verify(
          () => firebaseFunctions.httpsCallable(
            Functions.connectAuthenticator,
          ),
        ).called(1);

        verify(() => callable.call<void>(params)).called(1);
      });

      test(
        'onFirebaseFunctionsException logs message and throws error again',
        () {
          final firebaseException = FirebaseFunctionsException(
            code: 'code',
            message: 'message',
          );
          final params = <String, dynamic>{};
          when(() => callable.call<void>(params)).thenThrow(firebaseException);

          expect(
            () => usersApiClient.connectAuthenticator(params),
            throwsA(
              firebaseException,
            ),
          );

          verify(
            () => firebaseFunctions.httpsCallable(
              Functions.connectAuthenticator,
            ),
          ).called(1);

          verify(() => callable.call<void>(params)).called(1);
        },
      );

      test('throws exception when function throws exception', () {
        final exception = Exception('oops');
        final params = <String, dynamic>{};
        when(() => callable.call<void>(params)).thenThrow(exception);

        expect(
          () => usersApiClient.connectAuthenticator(params),
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
  });
}
