import 'package:blog_app/features/chat/chats_screen/models/chat_outer_view.dart';
import 'package:blog_app/features/chat/shared/models/message.dart';

class ChatAPI {
  static Future<List<ChatOuterView>> getChats() async {
    return [
      ChatOuterView(
        friendId: 'user_002',
        friendImage: 'https://i.pravatar.cc/300?img=47',
        friendName: 'Sara Ahmed',
        lastMessage: Message(
          sender: Sender.friend,
          content: 'I am waiting for your response!',
          time: DateTime.now().subtract(const Duration(minutes: 12)),
        ),
      ),
      ChatOuterView(
        friendId: 'user_003',
        friendImage: null,
        friendName: 'Omar Hassan',
        lastMessage: Message(
          sender: Sender.friend,
          content: 'Did you see the new post?',
          time: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ),
    ];
  }
}
