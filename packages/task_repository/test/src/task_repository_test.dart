// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_repository/src/task_repository.dart';

class _MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('TaskRepository', () {
    test('can be extended', () {
      expect(
        _MockTaskRepository(),
        isA<TaskRepository>(),
      );
    });
  });
}
