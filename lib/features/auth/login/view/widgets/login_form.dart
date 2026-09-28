import 'package:blog_app/core/helpers/validators.dart';
import 'package:blog_app/core/widgets/app_inputs/app_form_field.dart';
import 'package:blog_app/features/auth/login/manager/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormWidget extends StatelessWidget {
  final _formKey;
  LoginFormWidget({super.key, required this._formKey});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppFormField(
            hintText: "Email",
            controller: emailController,
            validator: Validators.emailValidation,
          ),
          SizedBox(height: 5),
          AppFormField(
            isPassword: true,
            hintText: "Password",
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password cannot be empty';
              }
              return null;
            }
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginCubit>().loginWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text
                    );
                  }
                },
                child: Text("Login"),
              ),
              ElevatedButton(
                onPressed: () async {
                  context.read<LoginCubit>().signinWithGoogle();
                },
                child: Text("Login with Google"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
