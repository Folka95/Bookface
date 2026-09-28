import 'package:blog_app/core/models/user.dart';
import 'package:blog_app/features/feed/models/feed_sorter/abstract_feed_sorter.dart';
import 'package:blog_app/shared/models/post_model.dart';

class DefaultFeedSorter extends AbstractFeedSorter {
  @override
  List<Post> sort(List<Post> posts, MyUser user) {
    return posts;
  }
}
