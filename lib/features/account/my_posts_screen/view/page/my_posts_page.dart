import 'package:blog_app/core/widgets/app_message.dart';
import 'package:blog_app/core/widgets/app_top_bar.dart';
import 'package:blog_app/features/account/my_posts_screen/manager/my_posts_cubit.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:blog_app/shared/widgets/post_card/view/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPostsPage extends StatelessWidget {
  const MyPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyPostsCubit()..loadMyPosts(),
      child: Scaffold(
          appBar: AppTopBar(title: "My Posts"),

          body: BlocBuilder<MyPostsCubit, MyPostsState>(
            builder: (context, state) {
              switch (state) {
                case MyPostsInitial():
                case MyPostsLoading():
                  return const Center(child: CircularProgressIndicator());

                case MyPostsFailure(:final message):
                  return Center(child: Text(message));

                case MyPostsLoaded(:final myPosts):
                  return _buildMyPosts(context, myPosts, () async {
                    await context.read<MyPostsCubit>().loadMyPosts();
                  });
              }
            },
          ),
      ),
    );
  }

  Widget _buildMyPosts(
    BuildContext context,
    List<Feed> myPosts,
    Future<void> Function() refresh,
  ) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...myPosts.map(
              (myPosts) => PostCard(
                post: myPosts.post,
                authorImage: myPosts.authorImage,
                authorName: myPosts.authorName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
