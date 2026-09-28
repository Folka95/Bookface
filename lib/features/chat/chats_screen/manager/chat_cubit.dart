import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/shared/backend API/chat_api.dart';
import 'package:blog_app/features/chat/chats_screen/models/chat_outer_view.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatLoading());

  Future<void> loadChats() async {
    final response = await UserCache.get();
    if (response.isExpired) {
      emit(ChatExpiredCredits());
      return;
    }
    if (response.cached == null) {
      emit(ChatLoggedOut());
      return;
    }
    if (response.isOk) {
      final chats = await ChatAPI.getChats();
      emit(ChatLoaded(chats: chats));
      return;
    }
    emit(ChatFailure());
  }
}
