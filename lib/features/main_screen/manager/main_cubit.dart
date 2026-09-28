import 'package:blog_app/core/models/app_page.dart';
import 'package:blog_app/features/account/account_screen/view/page/account_page.dart';
import 'package:blog_app/features/chat/chats_screen/view/pages/chat_page.dart';
import 'package:blog_app/features/feed/view/pages/feed_page.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit()
    : super(
        MainInitial(
          index: 1,
          page: AppPage(title: 'Feed', page: FeedPage()),
        ),
      );

  // Bottom navigation
  void changePage(int index) {
    switch (index) {
      case 0:
        emit(
          MainLoaded(
            index: index,
            page: AppPage(title: 'Chat', page: ChatPage()),
          ),
        );
        break;

      case 1:
        emit(
          MainLoaded(
            index: index,
            page: AppPage(title: 'Feed', page: FeedPage()),
          ),
        );
        break;

      case 2:
        emit(
          MainLoaded(
            index: index,
            page: AppPage(title: 'Account', page: AccountPage()),
          ),
        );
        break;
    }
  }
}
