// ignore_for_file: prefer_const_constructors
import 'package:api_client/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

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
  });
}
