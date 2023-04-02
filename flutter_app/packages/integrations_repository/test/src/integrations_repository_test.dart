// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('IntegrationsRepository', () {
    test('can be instantiated', () {
      expect(IntegrationsRepository(any()), isNotNull);
    });
  });
}
