import 'package:blog_app/core/helpers/safe_print.dart';
import 'package:blog_app/core/widgets/app_message.dart';
import 'package:blog_app/features/auth/login/manager/login_cubit.dart';
import 'package:blog_app/features/auth/login/view/widgets/login_form.dart';
import 'package:blog_app/features/auth/signup/view/page/signup_screen.dart';
import 'package:blog_app/features/main_screen/manager/main_cubit.dart';
import 'package:blog_app/features/main_screen/view/pages/main_screen.dart';
import 'package:blog_app/shared/widgets/auth_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/widgets/have_account_or_no_widget.dart'
    show HaveAccountOrNotWidget;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          if (state is LoginFailure) {
            Navigator.pop(context);
            AppMessage.show(
              context,
              message: state.message,
              type: AppMessageType.failed,
            );
          }
          if (state is LoginSuccess) {
            Navigator.pop(context);
            if(Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            else {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return BlocProvider(
                      create: (BuildContext context) {
                        return MainCubit();
                      },
                      child: MainPage(),
                    );
                  },
                ),
              );
            }
            AppMessage.show(
              context,
              message: "Login Success",
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
                  title: "Welcome Back!",
                  subTitle: "Login Now, and Enjoy!",
                ),

                LoginFormWidget(
                  formKey: _formKey,
                ),

                HaveAccountOrNotWidget(
                  text: "Don't have account?",
                  actionText: 'signUp',
                  onTap: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => SignupScreen(),
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
