import 'package:blog_app/shared/backend API/post_api.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:blog_app/shared/models/post_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'Feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial());

  void reset() {
    emit(FeedLoading());
    loadFeed();
  }

  Future<void> toggleLike(Post post) async {
    try {
      final updatedPost = await PostAPI.toggleLike(post);
      final feeds = state is FeedLoaded
          ? (state as FeedLoaded).feeds
          : await PostAPI.getFeed();
      emit(
        FeedLoaded(
          feeds: feeds.map((feed) {
            if (feed.post.id != updatedPost.id) {
              return feed;
            }
            return Feed(
              post: updatedPost,
              authorImage: feed.authorImage,
              authorName: feed.authorName,
            );
          }).toList(),
        ),
      );
    } catch (e) {
      emit(FeedFailure(message: e.toString()));
    }
  }

  Future<bool> isLiked(Post post) async {
    return false;
  }

  Future<void> addPost(Post post, String userId) async {
    try {
      await PostAPI.addPost(post, userId);
      await loadFeed();
    } catch (e) {
      emit(FeedFailure(message: e.toString()));
    }
  }

  Future<void> loadFeed() async {
    emit(FeedLoading());
    try {
      final feeds = await PostAPI.getFeed();
      emit(FeedLoaded(feeds: feeds));
    } catch (e) {
      emit(FeedFailure(message: e.toString()));
    }
  }
}
