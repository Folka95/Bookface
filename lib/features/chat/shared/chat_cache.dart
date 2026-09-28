import 'dart:convert';

import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/features/chat/chats_screen/models/chat_outer_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/chat.dart';
import 'models/message.dart';

class ChatCache {
  static const String _chatIdsKey = 'cached_chat_ids';

  /// Save/update a complete chat.
  static Future<void> saveChat(Chat chat) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      ChatCache._chatKey(chat.friendId),
      jsonEncode({
        'friendId': chat.friendId,
        'messages': chat.messages.map((message) => message.toJson()).toList(),
      }),
    );

    final chatIds = prefs.getStringList(_chatIdsKey) ?? [];

    if (!chatIds.contains(chat.friendId)) {
      chatIds.add(chat.friendId);
      await prefs.setStringList(_chatIdsKey, chatIds);
    }
  }

  static Future<Chat?> getChat(String friendId) async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(ChatCache._chatKey(friendId));

    if (json == null) {
      return null;
    }

    try {
      final data = jsonDecode(json);

      final messages = (data['messages'] as List)
          .map(
            (message) => Message.fromJson(Map<String, dynamic>.from(message)),
          )
          .toList();

      return Chat(friendId: data['friendId'], messages: messages);
    } catch (_) {
      await ChatCache.clearChat(friendId);
      return null;
    }
  }

  static Future<List<Chat>> getAllChats() async {
    final prefs = await SharedPreferences.getInstance();

    final chatIds = prefs.getStringList(_chatIdsKey) ?? [];

    final chats = <Chat>[];

    for (final friendId in chatIds) {
      final chat = await ChatCache.getChat(friendId);

      if (chat != null) {
        chats.add(chat);
      }
    }

    return chats;
  }

  static Future<void> appendMessage(String friendId, Message message) async {
    final chat = await ChatCache.getChat(friendId);

    if (chat == null) {
      await ChatCache.saveChat(Chat(friendId: friendId, messages: [message]));

      return;
    }

    chat.messages.add(message);

    await ChatCache.saveChat(chat);
  }

  static Future<void> clearChat(String friendId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(ChatCache._chatKey(friendId));

    final chatIds = prefs.getStringList(_chatIdsKey) ?? [];

    chatIds.remove(friendId);

    await prefs.setStringList(_chatIdsKey, chatIds);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();

    final chatIds = prefs.getStringList(_chatIdsKey) ?? [];

    for (final friendId in chatIds) {
      await prefs.remove(ChatCache._chatKey(friendId));
    }

    await prefs.remove(_chatIdsKey);
  }

  static Future<List<ChatOuterView>> getOuterViews({
    required Future<MyUserData?> Function(String friendId) getUser,
  }) async {
    final chats = await ChatCache.getAllChats();

    final views = <ChatOuterView>[];

    for (final chat in chats) {
      final user = await getUser(chat.friendId);

      if (user == null) {
        continue;
      }

      views.add(
        ChatOuterView(
          friendId: chat.friendId,
          friendImage: user.profileImage,
          friendName: user.name ?? 'Unknown user',
          lastMessage: chat.messages.isEmpty ? null : chat.messages.last,
        ),
      );
    }

    return views;
  }

  static String _chatKey(String friendId) {
    return 'cached_chat_$friendId';
  }
}
