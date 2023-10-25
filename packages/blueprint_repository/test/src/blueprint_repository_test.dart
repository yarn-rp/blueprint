// ignore_for_file: prefer_const_constructors

import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBlueprintRepository extends Mock implements BlueprintRepository {}

void main() {
  group('TodaysBlueprintRepository', () {
    // can be extended
    test('can be extended', () {
      expect(
        _MockBlueprintRepository(),
        isA<BlueprintRepository>(),
      );
    });
  });
}
