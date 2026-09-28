import 'package:blog_app/core/theme/theme_manager.dart';
import 'package:blog_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:blog_app/core/widgets/app_top_bar.dart';
import 'package:blog_app/features/account/account_screen/view/page/account_page.dart';
import 'package:blog_app/features/chat/chats_screen/view/pages/chat_page.dart';
import 'package:blog_app/features/feed/view/pages/feed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/main_cubit.dart';
import '../../../../../core/models/app_page.dart';

class MainPage extends StatelessWidget {

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppTopBar(title: state.page.title, onBack: state.page.onBack),

          body: state.page.page,

          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: state.index,
            onItemSelected: (index) {
              context.read<MainCubit>().changePage(index);
            },
          )
        );
      },
    );
  }
}
