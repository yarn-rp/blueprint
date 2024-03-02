// ignore_for_file: prefer_const_constructors

import 'package:ai_client/ai_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ai_dart/generative_ai_dart.dart';
import 'package:mocktail/mocktail.dart';

class MockGenerativeModel extends Mock implements GenerativeModel {}

void main() {
  group('AiClient', () {
    test('can be instantiated', () {
      final aiClient = AiClient(generativeModel: MockGenerativeModel());
      expect(aiClient, isNotNull);
    });
  });
}
