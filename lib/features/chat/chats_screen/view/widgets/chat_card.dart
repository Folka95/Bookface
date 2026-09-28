import 'package:blog_app/features/chat/chat_screen/view/page/chat_details_page.dart';
import 'package:blog_app/features/chat/chats_screen/models/chat_outer_view.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final ChatOuterView chat;

  const ChatCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => ChatDetailsPage(
              chat: chat,
            ),
          ),
        );
      },

      // Profile image
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: chat.friendImage != null
            ? NetworkImage(chat.friendImage!)
            : null,
        child: chat.friendImage == null ? const Icon(Icons.person) : null,
      ),

      // Name + last message
      title: Text(
        chat.friendName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),

      subtitle: Text(
        chat.lastMessage?.content ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      // Time
      trailing: chat.lastMessage?.time == null
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${chat.lastMessage!.time.day}/'
                  '${chat.lastMessage!.time.month}/'
                  '${chat.lastMessage!.time.year}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  '${chat.lastMessage!.time.hour}${chat.lastMessage!.time.hour}:'
                  '${chat.lastMessage!.time.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    );
  }
}
