import 'package:bloc/bloc.dart';
import 'package:blog_app/core/models/user.dart';
import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/cache_response.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:blog_app/shared/data/interests_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../../core/helpers/safe_print.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = MyUser(id: credential.user!.uid);

      await UserCache.save(user);
      await UserDataCache.save(
        MyUserData(
          email: credential.user!.email,
          name: "Mohamed Khaled",
          about: "I love programing!",
          gender: Genders.male,
          nationality: "Egypt",
          birthdate: DateTime(31, 12, 2000),
          createdAt: DateTime(15, 3, 2018),
          lastActive: DateTime.now(),
          interests: const [Interests.gaming, Interests.programming],
        ),
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      safePrint(e.code);
      if (e.code == 'invalid-credential' || e.code == "invalid-email") {
        safePrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        safePrint('Wrong password provided for that user.');
      }
      emit(LoginFailure(message: e.code));
    }
  }

  signinWithGoogle() async {
    emit(LoginFailure(message: "Currently unavailable"));
    return;
    emit(LoginLoading());
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      safePrint(userCredential.user!.uid);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      safePrint(e.code);
      if (e.code == 'invalid-email') {
        safePrint('Invalid email.');
      } else if (e.code == 'weak-password') {
        safePrint('Weak password.');
      }
      emit(LoginFailure(message: e.code));
    }
  }
}
