import 'package:flutter/material.dart';

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
  late bool generatingBlueprint;

  List<types.Message> _messages = [];

  final _user = const types.User(
    id: 'current-user',
    firstName: 'you',
    role: types.Role.user,
  );

  final _bot = const types.User(
    id: 'bot',
    firstName: 'AI Assistant',
    role: types.Role.agent,
  );

  void _handleGenerateBlueprint() {
    print('Generating new Blueprint');

    setState(() {
      final message = _messages.removeAt(0);

      _messages.insert(
        0,
        types.TextMessage(
          id: message.id,
          text: 'Generate new Blueprint',
          author: _user,
        ),
      );
      generatingBlueprint = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingFocusNode = FocusNode();
    generatingBlueprint = false;
    _messages
      ..add(
        types.CustomMessage(
          id: '4',
          author: _user,
          type: types.MessageType.custom,
          metadata: {
            'type': 'actions',
            'actions': [
              {
                'id': 'generate',
                'text': 'Generate new Blueprint',
              },
            ],
          },
        ),
      )
      ..add(
        types.TextMessage(
          id: '3',
          text: 'I can also help you create a new Blueprint for today. '
              'Just tell me what you want to do and when, and I will take care '
              'of the rest.',
          author: _bot,
        ),
      )
      ..add(
        types.TextMessage(
          id: '2',
          text: 'This is your AI assistant. I am here to help you create the '
              '"Blueprint of your Day". To your left you have the current '
              'status for today. You can add, edit, or delete entries '
              'manually, or you can ask me to do it for you.',
          author: _bot,
        ),
      )
      ..add(
        types.TextMessage(
          id: '1',
          text: 'Hey there! ',
          author: _bot,
        ),
      );
  }

  void _handleSendPressed(types.PartialText message) {
    setState(() {
      final textMessage = types.TextMessage(
        text: message.text,
        author: _user,
        id: (_messages.length + 1).toString(),
      );

      _messages.insert(0, textMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Chat(
        messages: _messages,
        showUserNames: true,
        user: _user,
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: [
            if (generatingBlueprint) _bot,
          ],
        ),
        customBottomWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            focusNode: _textEditingFocusNode,
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Type a message',
              border: const OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.send,
                color: colorScheme.primary,
              ),
            ),
            onSubmitted: (value) {
              _handleSendPressed(types.PartialText(text: value));
              _textEditingController.clear();
              _textEditingFocusNode.requestFocus();
            },
          ),
        ),
        bubbleBuilder: (
          Widget widget, {
          required types.Message message,
          required bool nextMessageInGroup,
        }) {
          final isBot = message.author.id == _bot.id;

          if (message.type == types.MessageType.custom) {
            return widget;
          }
          return Card(
            color: isBot ? null : colorScheme.primary,
            child: widget,
          );
        },
        customMessageBuilder: (
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
        },
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
        onSendPressed: _handleSendPressed,
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
    final textTheme = theme.textTheme;

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
          onPressed: () {
            print('Generating new Blueprint');
            _handleGenerateBlueprint();
          },
          child: const Text(
            'Generate new Blueprint',
          ),
        ),
      ),
    );
  }
}
