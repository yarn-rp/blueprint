// ignore_for_file: prefer_const_constructors

import 'package:ai_client/ai_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ai_dart/generative_ai_dart.dart';
import 'package:mocktail/mocktail.dart';

class MockGenerativeModel extends Mock implements GenerativeModel {}

void main() {
  group('AiClient', () {
    group('GeminiClient', () {
      late GenerativeModel generativeModel;
      late AiClient aiClient;

      setUp(() {
        generativeModel = MockGenerativeModel();
        aiClient = GeminiAiClient(generativeModel: generativeModel);
      });

      test('isA AiClient', () {
        expect(aiClient, isA<AiClient>());
      });
    });
  });
}
