import 'package:blog_app/shared/models/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final String? authorImage;
  final String authorName;
  final String? authorId;

  const PostCard({
    super.key,
    required this.post,
    required this.authorImage,
    required this.authorName,
    this.authorId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Placeholder(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAuthor(),

              const SizedBox(height: 12),

              Text(post.content+post.content+post.content, style: Theme.of(context).textTheme.bodyLarge),

              if (post.images.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildImages(),
              ],

              const SizedBox(height: 16),

              _buildStatistics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthor() {
    return InkWell(
      onTap: null,
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: authorImage != null
                ? NetworkImage(authorImage!)
                : null,
            child: authorImage == null
                ? Text(
                    authorName.isNotEmpty ? authorName[0].toUpperCase() : '?',
                  )
                : null,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              authorName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          IconButton(onPressed: null, icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }

  Widget _buildImages() {
    if (post.images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(post.images.first, fit: BoxFit.cover),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == post.images.length - 1 ? 0 : 8,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(post.images[index], fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.favorite_border),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),

        const SizedBox(width: 4),

        Text('${post.likes}'),

        const SizedBox(width: 20),

        const Icon(Icons.comment_outlined, size: 20),

        const SizedBox(width: 4),

        Text('${post.comments}'),
      ],
    );
  }
}
