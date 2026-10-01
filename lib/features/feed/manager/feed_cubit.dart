import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:blog_app/core/storage/cache_response.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:blog_app/shared/models/post_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    } catch (e) {
      emit(FeedFailure(message: e.toString()));
    }
  }

  Future<bool> isLiked(Post post) async {
    return false;
  }

  Future<void> addPost({
    required String content,
    required String userId,
  }) async {
    try {
      final db = FirebaseFirestore.instance;

      final doc = db.collection("posts").doc();

      await doc.set({
        'authorId': userId,
        'content': content,
        'likes': 0,
        'comments': [],
      });

      await loadFeed();
    } catch (e) {
      emit(FeedFailure(message: e.toString()));
    }
  }

  Future<void> loadFeed() async {
    emit(FeedLoading());
    try {
      final db = FirebaseFirestore.instance;
      final users = db.collection("users");

      final List<Feed> feed = [];

      final querySnapshot = await db.collection("posts").get();
      for (final docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();

        final post = {
          ...(data as Map<String, dynamic>),
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
        final String profileImage = userData['profileImage'] ?? '';

        feed.add(
          Feed.fromJson({
            'post': post,
            'authorName': name,
            'authorImage': profileImage,
          }),
        );
      }
      final response = await UserCache.get();

      if(response.isOk && response.cached != null) {
        emit(FeedLoaded(
          userId: response.cached!.id,
          feeds: feed,
        ));
      }
      else {
        UserCache.clear();
        emit(FeedLoaded(
          userId: null,
          feeds: feed,
        ));
      }

    } catch (e) {
      emit(FeedFailure(message: e.toString()));
    }
  }
}
