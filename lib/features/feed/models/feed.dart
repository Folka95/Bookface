import 'package:blog_app/shared/models/post_model.dart';

class Feed {
  final Post post;
  final String authorName;
  final String authorImage;

  Feed({
    required this.post,
    required this.authorName,
    required this.authorImage,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      post: Post.fromJson(json['post'] as Map<String, dynamic>),
      authorName: json['authorName'] as String,
      authorImage: json['authorImage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post': post.toJson(),
      'authorName': authorName,
      'authorImage': authorImage,
    };
  }
}

