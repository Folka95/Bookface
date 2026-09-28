import 'package:blog_app/core/widgets/app_top_bar.dart';
import 'package:blog_app/features/chat/chats_screen/models/chat_outer_view.dart';
import 'package:blog_app/features/chat/shared/models/message.dart';
import 'package:blog_app/shared/pages/app_screen.dart';
import 'package:flutter/material.dart';

class ChatDetailsPage extends StatelessWidget {
  final ChatOuterView chat;

   ChatDetailsPage({
    super.key,
    required this.chat,
  });
  final messages = [
    Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),      Message(
      sender: Sender.friend,
      content: 'Hello! How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
  ];
  @override
  Widget build(BuildContext context) {

    return AppScreen(
      appTopBar: AppTopBar(title: chat.friendName) ,
      widget:    ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isMine = message.sender == Sender.me;
          return Align(
            alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMine
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(message.content),
            ),
          );
        },
      ),
    );

  }
}
