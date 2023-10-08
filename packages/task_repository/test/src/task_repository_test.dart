// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:task_repository/task_repository.dart';

void main() {
  group('TaskRepository', () {
    test('can be instantiated', () {
      expect(TaskRepository(), isNotNull);
    });
  });
}
