import 'package:blog_app/shared/models/post_model.dart';
import 'package:blog_app/shared/models/post_topics.dart';
import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  final String userId;
  final void Function(Post post, String userId) onSubmit;

  const NewPost({super.key, required this.userId, required this.onSubmit});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final contentController = TextEditingController();

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new post',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'What is on your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                final content = contentController.text.trim();
                if (content.isEmpty) {
                  return;
                }
                widget.onSubmit(
                  Post(
                    id: 'post_${DateTime.now().millisecondsSinceEpoch}',
                    authorId: widget.userId,
                    content: content,
                    images: [],
                    topics: [Topics().personal],
                    views: 0,
                    likes: 0,
                    comments: 0,
                  ),
                  widget.userId,
                );
                contentController.clear();
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.send),
              label: const Text('Publish'),
            ),
          ],
        ),
      ),
    );
  }
}
