import 'package:blog_app/core/helpers/validators.dart';
import 'package:blog_app/core/widgets/app_inputs/app_form_field.dart';
import 'package:blog_app/features/auth/signup/manager/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupFormWidget extends StatelessWidget {
  final formKey;

  SignupFormWidget({
    super.key,
    required this.formKey,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppFormField(
            hintText: 'Email',
            controller: emailController,
            validator: Validators.emailValidation,
          ),
          const SizedBox(height: 5),
          AppFormField(
            isPassword: true,
            hintText: 'Password',
            controller: passwordController,
            validator: Validators.passwordValidation,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<SignupCubit>().signupWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                },
                child: const Text('Signup'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SignupCubit>().signupWithGoogle();
                },
                child: const Text('Sign up with Google'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
