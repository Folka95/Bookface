import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/features/account/profile_screen/view/page/profile_page.dart';

class ShortInfoPage extends StatelessWidget {
  final MyUserData user;

  const ShortInfoPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage: user.profileImage == null
                  ? null
                  : NetworkImage(user.profileImage!),
              child: user.profileImage == null
                  ? const Icon(Icons.person, size: 45)
                  : null,
            ),

            const SizedBox(height: 14),

            Text(
              user.name ?? 'Profile',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final identity = await UserCache.get();
                  final userId = identity.cached?.id;
                  if (userId == null || !context.mounted) {
                    return;
                  }
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return ProfilePage(userId: userId, title: 'My Profile');
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.person_outline),
                label: const Text('View profile'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
