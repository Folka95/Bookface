import 'package:blog_app/features/feed/manager/feed_cubit.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:blog_app/shared/widgets/post_card/view/post_card.dart';
import 'package:blog_app/features/feed/view/widgets/new_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit()..loadFeed(),
      child: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) {
          switch (state) {
            case FeedInitial():
            case FeedLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );

            case FeedFailure(:final message):
              return Center(
                child: Text(message),
              );

            case FeedLoaded(
                :final feeds,
                :final userId,
            ):
              return _buildFeed(
                context,
                feeds,
                userId,
                    () async {
                  await context.read<FeedCubit>().loadFeed();
                },
              );
          }
        },
      ),
    );
  }

  Widget _buildFeed(
      BuildContext context,
      List<Feed> feeds,
      String? userId,
      Future<void> Function() refresh,
      ) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userId != null)
              NewPost(
                userId: userId,
                onSubmit: (content, userId) async {
                  await context.read<FeedCubit>().addPost(
                    content: content,
                    userId: userId,
                  );
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