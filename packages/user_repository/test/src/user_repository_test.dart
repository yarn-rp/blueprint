// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

class _MockTaskRepository extends Mock implements UserRepository {}

void main() {
  group('UserRepository', () {
    test('can be extended', () {
      expect(
        _MockTaskRepository(),
        isA<UserRepository>(),
      );
    });
  });
}
