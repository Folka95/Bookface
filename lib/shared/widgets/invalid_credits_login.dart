import 'package:blog_app/core/models/app_page.dart';
import 'package:blog_app/features/auth/login/view/page/login_screen.dart';
import 'package:blog_app/features/auth/signup/view/page/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvalidCredentialsLoginPage extends StatelessWidget {

  const InvalidCredentialsLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 64,
              ),

              const SizedBox(height: 24),

              const Text(
                'Login Required',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'You need to login or create an account '
                    'to access this page.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => SignupScreen(),
                      ),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
