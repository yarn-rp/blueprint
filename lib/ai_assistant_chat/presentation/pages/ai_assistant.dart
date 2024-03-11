import 'package:blueprint/ai_assistant_chat/state_management/bloc/ai_assistant_chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class AIAssistantChat extends StatefulWidget {
  const AIAssistantChat({super.key});

  @override
  State<AIAssistantChat> createState() => _AIAssistantChatState();
}

class _AIAssistantChatState extends State<AIAssistantChat> {
  late final TextEditingController _textEditingController;
  late final FocusNode _textEditingFocusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingFocusNode = FocusNode();
  }

  Widget _bubbleBuilder(
    Widget widget, {
    required types.Message message,
    required bool nextMessageInGroup,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bot = context.read<AiAssistantChatBloc>().state.bot;
    final isBot = message.author.id == bot.id;

    if (message.type == types.MessageType.custom) {
      return widget;
    }

    return Card(
      color: isBot ? null : colorScheme.primary,
      child: widget,
    );
  }

  Widget _nameBuilder(types.User user) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final bot = context.read<AiAssistantChatBloc>().state.bot;

    if (user.id == bot.id) {
      return Text(
        'AI Assistant',
        style: textTheme.bodySmall!.copyWith(
          color: colorScheme.primary,
        ),
      );
    }

    return Text(
      'Me',
      style: textTheme.bodySmall!.copyWith(
        color: colorScheme.onSurface,
      ),
    );
  }

  Widget _customMessageBuilder(
    types.CustomMessage message, {
    required int messageWidth,
  }) {
    final type = message.metadata?['type'] as String;

    return switch (type) {
      'actions' => _actionMessage(
          context,
          message.metadata?['actions'] as List<Map<String, String>>,
          messageWidth,
        ),
      _ => const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final messages = context.select(
      (AiAssistantChatBloc bloc) => bloc.state.messages,
    );

    final (me, bot) = context.select(
      (AiAssistantChatBloc bloc) => (bloc.state.me, bloc.state.bot),
    );

    final botIsTyping = context.select(
      (AiAssistantChatBloc bloc) => bloc.state.botIsTyping,
    );

    return Scaffold(
      body: Chat(
        theme: DefaultChatTheme(
          backgroundColor: colorScheme.background,
          secondaryColor: theme.cardTheme.color!,
          userNameTextStyle: textTheme.bodySmall!,
          typingIndicatorTheme: TypingIndicatorTheme(
            bubbleColor: colorScheme.background,
            animatedCircleSize: 14,
            animatedCirclesColor: theme.colorScheme.outline,
            bubbleBorder: BorderRadius.zero,
            countAvatarColor: Colors.transparent,
            countTextColor: Colors.transparent,
            multipleUserTextStyle: textTheme.bodySmall!,
          ),
          receivedMessageBodyTextStyle: textTheme.bodyLarge!.copyWith(
            color: colorScheme.onSurface,
          ),
          sentMessageBodyTextStyle: textTheme.bodyLarge!.copyWith(
            color: colorScheme.onPrimary,
          ),
          primaryColor: colorScheme.primary,
        ),
        messages: messages,
        showUserNames: true,
        user: me,
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: [
            if (botIsTyping) bot,
          ],
        ),
        customBottomWidget: _MessageTextField(
          textEditingFocusNode: _textEditingFocusNode,
          textEditingController: _textEditingController,
          handleSendPressed: (message) =>
              context.read<AiAssistantChatBloc>().add(
                    UserTextMessageSent(message),
                  ),
        ),
        bubbleBuilder: _bubbleBuilder,
        nameBuilder: _nameBuilder,
        customMessageBuilder: _customMessageBuilder,
        onSendPressed: (message) {
          context.read<AiAssistantChatBloc>().add(
                UserTextMessageSent(message),
              );
        },
      ),
    );
  }

  Widget _actionMessage(
    BuildContext context,
    List<Map<String, String>> actions,
    int messageWidth,
  ) {
    return SizedBox(
      width: messageWidth.toDouble(),
      child: Wrap(
        alignment: WrapAlignment.end,
        children: actions
            .map(
              (action) => switch (action['id']) {
                'generate' => generateBlueprintActionButton(context),
                _ => const SizedBox.shrink(),
              },
            )
            .toList(),
      ),
    );
  }

  Widget generateBlueprintActionButton(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 50,
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              theme.colorScheme.tertiary,
            ),
            foregroundColor: MaterialStateProperty.all(
              theme.colorScheme.onTertiary,
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Generate new Blueprint',
          ),
        ),
      ),
    );
  }
}

class _MessageTextField extends StatelessWidget {
  const _MessageTextField({
    required this.handleSendPressed,
    required this.textEditingFocusNode,
    required this.textEditingController,
  });

  final ValueChanged<types.PartialText> handleSendPressed;
  final FocusNode textEditingFocusNode;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        focusNode: textEditingFocusNode,
        controller: textEditingController,
        maxLines: 5,
        minLines: 1,
        textInputAction: TextInputAction.send,
        decoration: InputDecoration(
          hintText: 'Type a message',
          border: const OutlineInputBorder(),
          suffixIcon: Icon(
            Icons.send,
            color: colorScheme.primary,
          ),
        ),
        onSubmitted: (value) {
          handleSendPressed(types.PartialText(text: value));
          textEditingController.clear();
          textEditingFocusNode.requestFocus();
        },
      ),
    );
  }
}
