part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final MyUserData user;
  final List<Feed> posts;

  ProfileLoaded({required this.user, required this.posts});
}

final class ProfileExpired extends ProfileState {}

final class ProfileLoggedOut extends ProfileState {}

final class ProfileNotFound extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure({required this.message});
}
