import 'package:flutter/material.dart';

class SettingsButtonCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsButtonCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          ...children,
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,

      leading: Icon(icon),

      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),

      subtitle: Text(subtitle),

      trailing: const Icon(Icons.chevron_right),
    );
  }
}
