import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final double? toolbarHeight;

  const AppTopBar({super.key, required this.title, this.onBack, this.toolbarHeight = double.infinity});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight == null ? 0 : toolbarHeight,
      leading: onBack == null
          ? null
          : IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
      backgroundColor: Colors.deepPurple,
      title: Row(
        children: [
          Expanded(
            child: Text(title, overflow: TextOverflow.ellipsis, maxLines: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Image.asset('assets/images/logo.png', width: 50, height: 50),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
