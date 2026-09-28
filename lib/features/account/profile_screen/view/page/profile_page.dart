import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/widgets/app_message.dart';
import 'package:blog_app/core/widgets/app_top_bar.dart';
import 'package:blog_app/features/account/profile_screen/manager/profile_cubit.dart';
import 'package:blog_app/shared/widgets/invalid_credits_login.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:blog_app/shared/widgets/post_card/view/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final String title;

  const ProfilePage({super.key, required this.userId, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(userId),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppTopBar(title: title),
            body: _buildPage(context, state),
          );
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, ProfileState state) {
    switch (state) {
      case ProfileInitial():
      case ProfileLoading():
        return const Center(child: CircularProgressIndicator());

      case ProfileFailure(:final message):
        return Center(child: Text(message));

      case ProfileLoaded(:final user, :final posts):
        return RefreshIndicator(
          onRefresh: () => context.read<ProfileCubit>().refreshProfile(),
          child: _buildProfile(context, user, posts),
        );

      case ProfileExpired():
        AppMessage.show(
          context,
          message: "Last session has expired",
          type: AppMessageType.warning,
        );
        return InvalidCredentialsLoginPage();

      case ProfileLoggedOut():
        return InvalidCredentialsLoginPage();

      case ProfileNotFound():
        return const Center(child: Text('No such user'));
    }
  }

  Widget _buildProfile(
    BuildContext context,
    MyUserData user,
    List<Feed> posts,
  ) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: user.profileImage == null
                      ? null
                      : NetworkImage(user.profileImage!),
                  child: user.profileImage == null
                      ? const Icon(Icons.person, size: 48)
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  user.name ?? 'Profile',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                _field('Email', user.email),
                _field('About', user.about),
                _field('Gender', user.gender?.value),
                _field('Country', user.nationality),
                _field('Birthdate', _formatDate(user.birthdate)),
                _field('Created', _formatDate(user.createdAt)),
                _field('Last active', _formatDate(user.lastActive)),
                if (user.interests?.isNotEmpty == true)
                  _field(
                    'Interests',
                    user.interests!
                        .map((interest) => interest.value)
                        .join(', '),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Posts', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        if (posts.isEmpty) const Text('No posts yet.'),
        ...posts.map(
          (feed) => PostCard(
            post: feed.post,
            authorImage: feed.authorImage,
            authorName: feed.authorName,
            authorId: feed.post.authorId,
          ),
        ),
      ],
    );
  }

  Widget _field(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String? _formatDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
