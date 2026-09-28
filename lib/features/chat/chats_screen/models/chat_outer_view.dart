import 'package:blog_app/features/chat/shared/models/message.dart';

class ChatOuterView {
  final String friendId;
  final String? friendImage;
  final String friendName;
  final Message? lastMessage;

  ChatOuterView({
    required this.friendId,
    required this.friendImage,
    required this.friendName,
    required this.lastMessage,
  });
}
