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
}