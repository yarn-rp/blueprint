import 'dart:convert';

import 'package:ai_client/src/ai_client.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

/// {@template chat_gpt_ai_client}
/// A client to interact with the ChatGPT AI model.
/// {@endtemplate}
class ChatGPTAiClient implements AiClient {
  /// {@macro chat_gpt_ai_client}
  ChatGPTAiClient({
    required String apiKey,
  }) {
    _openAI = OpenAI.instance.build(
      token: apiKey,
    );
  }

  late final OpenAI _openAI;

  /// The model to use for the AI.
  ChatModel get _chatModel => Gpt4ChatModel();

  /// Prompt the AI with a message and receive a response.
  @override
  Future<String> generateContentString({
    required String content,
    Map<String, dynamic>? metadata,
  }) async {
    final metadataSerialized = jsonEncode(metadata);

    final request = ChatCompleteText(
      messages: [
        Messages(
          role: Role.user,
          content: '$content\n$metadataSerialized',
        ),
      ],
      maxToken: 400,
      model: _chatModel,
    );

    final response = await _openAI.onChatCompletion(request: request);

    if (response?.choices.isEmpty ?? true) {
      throw Exception('No response from AI model');
    }

    return response!.choices.first.message!.content;
  }
}
