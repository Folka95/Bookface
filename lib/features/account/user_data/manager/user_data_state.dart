part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataExpired extends UserDataState {
  final String message;

  UserDataExpired({required this.message});
}

final class UserDataLoaded extends UserDataState {
  final MyUserData? user;

  UserDataLoaded({
    required this.user,
  });
}

final class UserDataSaving extends UserDataState {}

final class UserDataSaved extends UserDataState {}
final class UserDataCompleted extends UserDataState {}

final class UserDataLoggedOut extends UserDataState {}

final class UserDataFailure extends UserDataState {
  final String message;

  UserDataFailure({required this.message});
}
