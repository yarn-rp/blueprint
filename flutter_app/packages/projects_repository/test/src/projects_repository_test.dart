// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:projects_repository/projects_repository.dart';

void main() {
  group('ProjectsRepository', () {
    test('can be instantiated', () {
      expect(ProjectsRepository(), isNotNull);
    });
  });
}
