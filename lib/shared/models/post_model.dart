class Comment {
  final String userId;
  final String content;

  Comment({
    required this.userId,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
    };
  }
}

class Post {
  final String id;
  final String authorId;
  final String content;
  final int likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.authorId,
    required this.content,
    required this.likes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      likes: json['likes'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((comment) => Comment.fromJson(comment as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'content': content,
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  Post copyWith({
    int? likes,
    List<Comment>? comments,
  }) {
    return Post(
      id: id,
      authorId: authorId,
      content: content,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}