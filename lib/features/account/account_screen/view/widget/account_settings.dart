import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/features/account/account_screen/models/setting_button_card.dart';
import 'package:blog_app/features/account/my_posts_screen/view/page/my_posts_page.dart';
import 'package:blog_app/features/auth/login/manager/login_cubit.dart';
import 'package:blog_app/features/auth/login/view/page/login_screen.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/features/chat/shared/chat_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_app/features/account/user_data/view/page/user_data_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettingsPage extends StatelessWidget {
  final MyUserData user;
  final String userId;

  const AccountSettingsPage({
    super.key,
    required this.userId,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsButtonCard(
      title: 'Account',
      children: [
        SettingsItem(
          icon: Icons.article_outlined,
          title: 'My posts',
          subtitle: 'View the posts you have published',
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(builder: (_) => const MyPostsPage()),
            );
          },
        ),

        SettingsItem(
          icon: Icons.edit_outlined,
          title: 'Edit profile',
          subtitle: 'Change your public information',
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (_) => UserDataPage(
                  isSignup: false,
                  userId: userId,
                ),
              ),
            );
          },
        ),

        SettingsItem(
          icon: Icons.lock_outline,
          title: 'Change password',
          subtitle: 'Update your account password',
          onTap: () => _showChangePasswordDialog(context),
        ),

        Center(
          child: SizedBox(
            width: 100,
            child: OutlinedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await UserCache.clear();
                await UserDataCache.clear();
                await ChatCache.clearAll();
                if (!context.mounted) {
                  return;
                }
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (BuildContext context) {
                          return LoginCubit();
                        },
                        child: LoginScreen(),
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async {
    final controller = TextEditingController();

    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Change password'),
            content: TextField(
              controller: controller,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New password',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  final password = controller.text.trim();
                  if (password.length < 6) {
                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      const SnackBar(
                        content: Text('Password must be at least 6 characters.'),
                      ),
                    );
                    return;
                  }

                  try {
                    await FirebaseAuth.instance.currentUser?.updatePassword(
                      password,
                    );
                    if (!dialogContext.mounted) {
                      return;
                    }
                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password updated successfully.'),
                      ),
                    );
                  } on FirebaseAuthException catch (error) {
                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      SnackBar(content: Text(error.message ?? error.code)),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    } finally {
      controller.dispose();
    }
  }
}
