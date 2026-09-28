import 'package:blog_app/core/widgets/app_message.dart';
import 'package:blog_app/features/chat/chats_screen/manager/chat_cubit.dart';
import 'package:blog_app/features/chat/chats_screen/models/chat_outer_view.dart';
import 'package:blog_app/features/chat/chats_screen/view/widgets/chat_card.dart';
import 'package:blog_app/shared/widgets/invalid_credits_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/features/chat/chat_screen/view/page/chat_details_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit()..loadChats(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatExpiredCredits) {
            AppMessage.show(
              context,
              message: "Last session has expired",
              type: AppMessageType.warning,
            );
          }
        },
        builder: (context, state) {
          if (state is ChatInitial || state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ChatFailure) {
            return Center(
              child: Text(
                state.error ?? 'Something went wrong',
              ),
            );
          }

          if (state is ChatLoaded) {
            return _buildChat(
              context,
              state.chats!,
                  () async {
                await context.read<ChatCubit>().loadChats();
              },
            );
          }

          if (state is ChatExpiredCredits) {
            return const InvalidCredentialsLoginPage();
          }

          if (state is ChatLoggedOut) {
            return const InvalidCredentialsLoginPage();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildChat(
      BuildContext context,
      List<ChatOuterView> chats,
      Future<void> Function() refresh,
      ) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return ChatCard(
            chat: chat,
          );
        },
      ),
    );
  }
}