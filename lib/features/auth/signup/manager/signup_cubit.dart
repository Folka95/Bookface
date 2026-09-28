import 'package:bloc/bloc.dart';
import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_app/core/models/user.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignupSuccess(
        userId: credential.user!.uid,
        userEmail: email,
      ));
    } on FirebaseAuthException catch (e) {
      safePrint(e.code);
      if (e.code == 'invalid-email') {
        safePrint('Invalid email.');
      } else if (e.code == 'weak-password') {
        safePrint('Weak password.');
      }
      emit(SignupFailure(message: e.code));
    }
  }

  signupWithGoogle() async {
    emit(SignupFailure(message: "Currently unavailable"));
    return;
  }
}
