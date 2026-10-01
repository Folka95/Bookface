import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  final String userId;
  final void Function(String content, String userId) onSubmit;

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
                widget.onSubmit(content, widget.userId);
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
