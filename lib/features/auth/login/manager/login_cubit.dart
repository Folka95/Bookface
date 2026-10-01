import 'package:bloc/bloc.dart';
import 'package:blog_app/core/models/user.dart';
import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/cache_response.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:blog_app/shared/data/interests_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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


      final db = FirebaseFirestore.instance;

      final doc = await db
          .collection("users")
          .doc(credential.user!.uid)
          .get();

      if (!doc.exists || doc.data() == null) {
        emit(LoginFailure(message: "No user data found"));
        return;
      }

      final data = MyUserData.fromJson(
        doc.data()!,
      );

      final user = MyUser(id: credential.user!.uid);
      await UserDataCache.save(data);
      await UserCache.save(user);

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
  }
}
