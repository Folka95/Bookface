part of 'feed_cubit.dart';

@immutable
sealed class FeedState {}

final class FeedInitial extends FeedState {}

final class FeedLoading extends FeedState {}

final class FeedLoaded extends FeedState {
  final List<Feed> feeds;

  FeedLoaded({required this.feeds});
}

final class FeedFailure extends FeedState {
  final String message;

  FeedFailure({required this.message});
}
