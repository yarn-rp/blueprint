part of 'ai_assistant_chat_bloc.dart';

class AiAssistantChatState extends Equatable {
  const AiAssistantChatState({
    required this.me,
    required this.bot,
    this.botIsTyping = false,
    this.messages = const <types.Message>[],
  });

  final List<types.Message> messages;
  final types.User me;
  final types.User bot;
  final bool botIsTyping;

  AiAssistantChatState copyWith({
    List<types.Message>? messages,
    types.User? me,
    types.User? bot,
    bool? botIsTyping,
  }) {
    return AiAssistantChatState(
      messages: messages ?? this.messages,
      me: me ?? this.me,
      bot: bot ?? this.bot,
      botIsTyping: botIsTyping ?? this.botIsTyping,
    );
  }

  @override
  List<Object> get props => [messages, botIsTyping];
}
