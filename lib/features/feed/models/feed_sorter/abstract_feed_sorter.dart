import 'package:blog_app/core/models/user.dart';
import 'package:blog_app/shared/models/post_model.dart';

abstract class AbstractFeedSorter {
  int interestScore(Post post, MyUser user) {
    return 0;
  }
  List<Post> sort(List<Post> posts, MyUser user);
}