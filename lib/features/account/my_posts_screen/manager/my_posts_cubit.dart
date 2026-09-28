import 'package:blog_app/shared/backend API/post_api.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit() : super(MyPostsInitial());

  void reset() {
    emit(MyPostsLoading());
    loadMyPosts();
  }

  Future<void> loadMyPosts() async {
    emit(MyPostsLoading());
    try {
      final feeds = await PostAPI.getCurrentUserPosts();
      emit(MyPostsLoaded(myPosts: feeds));
    } catch (e) {
      emit(MyPostsFailure(message: e.toString()));
    }
  }
}
