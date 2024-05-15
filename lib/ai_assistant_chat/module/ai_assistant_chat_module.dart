import 'package:blueprint/ai_assistant_chat/state_management/bloc/ai_assistant_chat_bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:task_repository/task_repository.dart';
import 'package:uuid/uuid.dart';

@module
abstract class AIAssistantChatModule {
  @injectable
  AiAssistantChatBloc aiAssistantChatBloc(
    BlueprintRepository blueprintRepository,
    TaskRepository taskRepository,
    Uuid uuid,
    @factoryParam List<String> initialBotMessages,
  ) =>
      AiAssistantChatBloc(
        uuid: uuid,
        blueprintRepository: blueprintRepository,
        taskRepository: taskRepository,
        initialBotMessages: initialBotMessages,
      );
}
