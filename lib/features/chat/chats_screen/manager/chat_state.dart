part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<ChatOuterView>? chats;

  ChatLoaded({required this.chats});
}

final class ChatExpiredCredits extends ChatState {}

final class ChatLoggedOut extends ChatState {}

final class ChatFailure extends ChatState {
  final String? error;

  ChatFailure({this.error});
}
