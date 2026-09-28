part of 'my_posts_cubit.dart';

@immutable
sealed class MyPostsState {}

final class MyPostsInitial extends MyPostsState {}

final class MyPostsLoading extends MyPostsState {}

final class MyPostsLoaded extends MyPostsState {
  final List<Feed> myPosts;

  MyPostsLoaded({required this.myPosts});
}

final class MyPostsFailure extends MyPostsState {
  final String message;

  MyPostsFailure({required this.message});
}
