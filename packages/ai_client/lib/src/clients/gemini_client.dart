import 'dart:convert';

import 'package:ai_client/ai_client.dart';
import 'package:generative_ai_dart/generative_ai_dart.dart';

/// {@template gemini_ai_client}
/// A client to interact with the Gemini AI model.
/// {@endtemplate}
class GeminiAiClient implements AiClient {
  /// {@macro gemini_}
  const GeminiAiClient({
    required GenerativeModel generativeModel,
  }) : _generativeModel = generativeModel;

  final GenerativeModel _generativeModel;

  /// Prompt the AI with a message and receive a response.
  @override
  Future<String> generateContentString({
    required String content,
    Map<String, dynamic>? metadata,
  }) async {
    final metadataSerialized = jsonEncode(metadata);

    final userContent = Content.user([
      Part.text('$content\n$metadataSerialized'),
    ]);

    final generateAIResponse =
        await _generativeModel.generateContent([userContent]);

    return generateAIResponse.text();
  }
}
