// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:jira_repository/jira_repository.dart';

void main() {
  group('JiraRepository', () {
    test('can be instantiated', () {
      expect(JiraRepository(), isNotNull);
    });
  });
}
