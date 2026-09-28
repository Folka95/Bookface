import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:blog_app/core/widgets/app_message.dart';
import 'package:blog_app/features/auth/login/view/page/login_screen.dart';
import 'package:blog_app/features/auth/signup/view/widgets/signup_form.dart';
import 'package:blog_app/features/auth/signup/manager/signup_cubit.dart';
import 'package:blog_app/shared/widgets/auth_header_widget.dart';
import 'package:blog_app/features/account/user_data/view/page/user_data_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/have_account_or_no_widget.dart'
    show HaveAccountOrNotWidget;

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            safePrint("loading");
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          if (state is SignupFailure) {
            Navigator.pop(context);
            AppMessage.show(
              context,
              message: state.message,
              type: AppMessageType.failed,
            );
          }
          if (state is SignupSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return UserDataPage(
                    isSignup: true,
                    userId: state.userId,
                    userEmail: state.userEmail,
                  );
                },
              ),
            );
            AppMessage.show(
              context,
              message: "Signup Done",
              type: AppMessageType.success,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: Center(
            child: Column(
              spacing: 10,
              children: [
                AuthHeaderWidget(
                  title: "Welcome!",
                  subTitle: "Register Now, and Enjoy new feeds!",
                ),

                SignupFormWidget(
                    formKey: _formKey,
                ),
                HaveAccountOrNotWidget(
                  text: "Already have account?",
                  actionText: 'Login!',
                  onTap: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
