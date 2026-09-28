import 'package:blog_app/shared/models/post_topics.dart';

class Post {
  final String id;
  final String authorId;
  final String content;
  final List<String> images;
  final List<Topic> topics;
  final int views;
  final int likes;
  final int comments;

  Post({
    required this.id,
    required this.authorId,
    required this.content,
    required this.images,
    required this.topics,
    required this.views,
    required this.likes,
    required this.comments,
  });

  Post copyWith({int? views, int? likes, int? comments}) {
    return Post(
      id: id,
      authorId: authorId,
      content: content,
      images: images,
      topics: topics,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
