import 'package:blog_app/features/feed/models/feed.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/shared/models/post_model.dart';
import 'package:blog_app/shared/models/post_topics.dart';

class PostAPI {
  static final List<Feed> _posts = [
    ...List.generate(
      5,
      (index) => Feed(
        post: Post(
          id: 'post_other_${index + 1}',
          authorId: 'user_other_${index + 1}',
          content: 'A mocked post from another user ${index + 1}.',
          images: [],
          topics: [Topics().personal],
          views: 10 + index,
          likes: 2 + index,
          comments: index,
        ),
        authorImage: 'https://i.pravatar.cc/300?img=${20 + index}',
        authorName: 'Mocked User ${index + 1}',
      ),
    ),
  ];

  static Future<List<Feed>> getFeed() async {
    return PostAPI.getAllPosts();
  }

  static Future<List<Feed>> getAllPosts() async {
    final posts = List<Feed>.from(_posts);
    final identity = await UserCache.get();
    final userId = identity.cached?.id;
    if (userId != null) {
      posts.insertAll(0, PostAPI._currentUserPosts(userId));
    }
    return posts;
  }

  static Future<List<Feed>> getPostsByUser(String userId) async {
    final identity = await UserCache.get();
    if (identity.cached?.id == userId) {
      return PostAPI._currentUserPosts(userId);
    }

    final otherPosts =
        _posts.where((feed) => feed.post.authorId == userId).toList()
          ..shuffle();
    return otherPosts.take(5).toList();
  }

  static Future<List<Feed>> getCurrentUserPosts() async {
    final identity = await UserCache.get();
    final userId = identity.cached?.id;
    if (userId == null) {
      return [];
    }
    return PostAPI.getPostsByUser(userId);
  }

  static List<Feed> _currentUserPosts(String userId) {
    return List.generate(
      3,
      (index) => Feed(
        post: Post(
          id: 'post_current_${index + 1}',
          authorId: userId,
          content: 'A mocked post from your profile ${index + 1}.',
          images: [],
          topics: [Topics().personal],
          views: 20 + index,
          likes: 5 + index,
          comments: index,
        ),
        authorImage: 'https://i.pravatar.cc/300?img=12',
        authorName: 'Mohamed Khaled',
      ),
    );
  }

  static Future<void> addPost(Post post, String userId) async {
    _posts.insert(
      0,
      Feed(
        post: post,
        authorImage: 'https://i.pravatar.cc/300?img=12',
        authorName: 'Mohamed Khaled',
      ),
    );
  }

  static Future<Post> toggleLike(Post post) async {
    final index = _posts.indexWhere((feed) => feed.post.id == post.id);
    if (index == -1) {
      return post;
    }

    final updatedPost = post.copyWith(likes: post.likes + 1);
    _posts[index] = Feed(
      post: updatedPost,
      authorImage: _posts[index].authorImage,
      authorName: _posts[index].authorName,
    );
    return updatedPost;
  }
}
