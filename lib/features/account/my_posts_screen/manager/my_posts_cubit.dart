import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit() : super(MyPostsInitial());

  void reset() {
    loadMyPosts();
  }

  Future<void> loadMyPosts() async {
    emit(MyPostsLoading());

    try {
      final identity = await UserCache.get();

      if (!identity.isOk || identity.cached == null) {
        throw "credits expired, refresh and login again";
      }

      final userId = identity.cached!.id;

      final db = FirebaseFirestore.instance;
      final users = db.collection("users");

      final querySnapshot = await db
          .collection("posts")
          .where(
        "authorId",
        isEqualTo: userId,
      )
          .get();

      final List<Feed> feed = [];

      for (final docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();

        final post = {
          ...data,
          'id': docSnapshot.id,
        };

        final userDoc = await users
            .doc(data['authorId'])
            .get();

        if (!userDoc.exists || userDoc.data() == null) {
          continue;
        }

        final userData = userDoc.data()!;

        final String name = userData['name'] ?? '';
        final String profileImage =
            userData['profileImage'] ?? '';

        feed.add(
          Feed.fromJson({
            'post': post,
            'authorName': name,
            'authorImage': profileImage,
          }),
        );
      }

      emit(
        MyPostsLoaded(
          myPosts: feed,
        ),
      );
    } catch (e) {
      emit(
        MyPostsFailure(
          message: e.toString(),
        ),
      );
    }
  }
}