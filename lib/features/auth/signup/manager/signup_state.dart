part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}



final class SignupSuccess extends SignupState {
  final String userId;
  final String userEmail;
  SignupSuccess({
    required this.userId,
    required this.userEmail,
  });
}


final class SignupFailure extends SignupState {
  final String message;
  SignupFailure({required this.message});
}
