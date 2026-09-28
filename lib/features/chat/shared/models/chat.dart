import 'package:blog_app/features/chat/shared/models/message.dart';

class Chat {
  final List<Message> messages;
  final String friendId;
  Chat({required this.messages, required this.friendId});
}
