import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,

      onTap: (index) {
        onItemSelected(index);
      },

      type: BottomNavigationBarType.fixed,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          activeIcon: Icon(Icons.article),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }
}