import 'package:blog_app/features/feed/manager/feed_cubit.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:blog_app/shared/widgets/post_card/view/post_card.dart';
import 'package:blog_app/features/feed/view/widgets/new_post.dart';
import 'package:blog_app/features/account/profile_screen/view/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit()..loadFeed(),
      child: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) {
          switch (state) {
            case FeedInitial():
            case FeedLoading():
              return const Center(child: CircularProgressIndicator());

            case FeedFailure(:final message):
              return Center(child: Text(message));

            case FeedLoaded(:final feeds):
              return _buildFeed(context, feeds, () async {
                await context.read<FeedCubit>().loadFeed();
              });
          }
        },
      ),
    );
  }

  Widget _buildFeed(
    BuildContext context,
    List<Feed> feeds,
    Future<void> Function() refresh,
  ) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewPost(
              userId: 'user_001',
              onSubmit: (post, userId) async {
                await context.read<FeedCubit>().addPost(post, userId);
              },
            ),
            ...feeds.map(
              (feed) => PostCard(
                post: feed.post,
                authorImage: feed.authorImage,
                authorName: feed.authorName,
                authorId: feed.post.authorId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
