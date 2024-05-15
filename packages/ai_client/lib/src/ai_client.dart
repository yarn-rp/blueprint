/// {@template ai_client}
/// A client to interact with the AI model.
/// {@endtemplate}
// ignore_for_file: one_member_abstracts
abstract class AiClient {
  /// Prompt the AI with a message and receive a response.
  Future<String> generateContentString({
    required String content,
    Map<String, dynamic>? metadata,
  });
}
