part of 'account_cubit.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountLoaded extends AccountState {
  final MyUserData user;
  final String userId;
  AccountLoaded({
    required this.user,
    required this.userId,
  });
}

final class AccountExpired extends AccountState {}

final class AccountLoggedOut extends AccountState {}

final class AccountFailure extends AccountState {
  final String message;

  AccountFailure({required this.message});
}
