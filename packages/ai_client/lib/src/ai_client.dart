import 'dart:convert';

import 'package:generative_ai_dart/generative_ai_dart.dart';

/// {@template ai_client}
/// A client to interact with the AI model.
/// {@endtemplate}
class AiClient {
  /// {@macro ai_client}
  const AiClient({
    required GenerativeModel generativeModel,
  }) : _generativeModel = generativeModel;

  final GenerativeModel _generativeModel;

  /// Prompt the AI with a message and receive a response.
  Future<String> generateContentString({
    required String content,
    Map<String, dynamic>? metadata,
  }) async {
    final metadataSerialized = jsonEncode(metadata);

    final generateAIResponse = await _generativeModel.generateContent([
      Content.user([Part.text(content), Part.text(metadataSerialized)]),
    ]);

    return generateAIResponse.text();
  }
}
