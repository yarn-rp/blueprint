// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:google_calendar_repository/google_calendar_repository.dart';

void main() {
  group('GoogleCalendarRepository', () {
    test('can be instantiated', () {
      expect(GoogleCalendarRepository(), isNotNull);
    });
  });
}
