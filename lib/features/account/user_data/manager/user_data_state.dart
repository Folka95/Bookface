part of 'user_data_cubit.dart';

sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataExpired extends UserDataState {
  final String message;

  UserDataExpired({required this.message});
}

final class UserDataLoaded extends UserDataState {
  final MyUserData? user;
  final bool firstLoad;
  final String isBirthdateError;
  final String isGenderError;
  final String isNationalityError;
  final String isInterestsError;
  final String isProfilePhotoError;
  UserDataLoaded({
    required this.user,
    required this.firstLoad,
    this.isBirthdateError = "",
    this.isGenderError = "",
    this.isNationalityError = "",
    this.isInterestsError = "",
    this.isProfilePhotoError = "",
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
