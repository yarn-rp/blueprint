// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:user_api_client/user_api_client.dart';

void main() {
  group('UserApiClient', () {
    test('can be instantiated', () {
      expect(UserApiClient(), isNotNull);
    });
  });
}
