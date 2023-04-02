// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/project_repository.dart';

void main() {
  group('ProjectRepository', () {
    test('can be instantiated', () {
      expect(ProjectRepository(any()), isNotNull);
    });
  });
}
