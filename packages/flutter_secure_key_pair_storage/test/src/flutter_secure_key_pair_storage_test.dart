// ignore_for_file: prefer_const_constructors

import 'package:flutter_secure_key_pair_storage/flutter_secure_key_pair_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('FlutterSecureKeyPairStorage', () {
    test('can be instantiated', () {
      expect(
        FlutterSecureKeyPairStorage(
          flutterSecureStorage: MockFlutterSecureStorage(),
        ),
        isNotNull,
      );
    });
  });
}
