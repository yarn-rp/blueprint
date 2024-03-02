part of 'ai_assistant_chat_bloc.dart';

sealed class AiAssistantChatEvent extends Equatable {
  const AiAssistantChatEvent();
}

class UserTextMessageSent extends AiAssistantChatEvent {
  const UserTextMessageSent(this.message);

  final types.PartialText message;

  @override
  List<Object> get props => [message];
}
