import 'package:blog_app/core/widgets/app_message.dart';
import 'package:blog_app/core/widgets/app_top_bar.dart';
import 'package:blog_app/features/account/user_data/manager/user_data_cubit.dart';
import 'package:blog_app/features/account/user_data/view/widgets/user_data_form.dart';
import 'package:blog_app/features/auth/login/view/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataPage extends StatelessWidget {
  final String userId;
  final bool isSignup;
  final String? userEmail;

  final _formKey = GlobalKey<FormState>();

  UserDataPage({
    super.key,
    required this.isSignup,
    required this.userId,
    this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit(
        isSignup: isSignup,
        userId: userId,
        userEmail: userEmail,
      )..load(),
      child: BlocListener<UserDataCubit, UserDataState>(
        listener: (context, state) {
          if (state is UserDataLoading || state is UserDataSaving) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          if (state is UserDataFailure) {
            Navigator.pop(context);
            AppMessage.show(
              context,
              message: state.message,
              type: AppMessageType.failed,
            );
          }
          if (state is UserDataExpired) {
            Navigator.pop(context);
            AppMessage.show(
              context,
              message: "Your credits has expired, please login again",
              type: AppMessageType.warning,
            );
          }
          if (state is UserDataCompleted) {
            AppMessage.show(
              context,
              message: "Profile completed, you can login now!",
              type: AppMessageType.success,
            );
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
                  (route) => false,
            );
          }
          if (state is UserDataSaved) {
            Navigator.pop(context);
            AppMessage.show(
              context,
              message: "Profile saved!",
              type: AppMessageType.success,
            );
          }
        },
        child: Scaffold(
          appBar: AppTopBar(
            title: isSignup ? 'Complete Profile' : "Edit Profile",
            onBack: () {
                Navigator.pop(context);
            },
          ),
          body: UserDataForm(
              formKey: _formKey,
          ),
        ),
      ),
    );
  }
}
