// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:local_integrations_repository/local_integrations_repository.dart';

void main() {
  group('IntegrationsRepository', () {
    test('can be instantiated', () {
      expect(LocalIntegrationsRepository(), isNotNull);
    });
  });
}
