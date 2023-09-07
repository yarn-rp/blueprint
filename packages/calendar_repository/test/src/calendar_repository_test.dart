// ignore_for_file: prefer_const_constructors

import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final class _MockCalendarRepository extends Mock
    implements CalendarRepository {}

void main() {
  group('CalendarRepository', () {
    test('can be extended', () {
      expect(_MockCalendarRepository(), isA<CalendarRepository>());
    });
  });
}
