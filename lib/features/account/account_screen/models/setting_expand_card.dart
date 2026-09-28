import 'package:flutter/material.dart';

class SettingsExpandCard extends StatefulWidget {
  final String title;
  final List<SettingsExpandItem> children;

  const SettingsExpandCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  State<SettingsExpandCard> createState() => _SettingsExpandCardState();
}

class _SettingsExpandCardState extends State<SettingsExpandCard> {
  int? expandedIndex;

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
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          ...List.generate(widget.children.length, (index) {
            final item = widget.children[index];
            final isExpanded = expandedIndex == index;

            return Column(
              children: [
                ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
                  trailing: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        expandedIndex = null;
                      } else {
                        expandedIndex = index;
                      }
                    });
                  },
                ),

                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: item.content,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class SettingsExpandItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget content;

  const SettingsExpandItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.content,
  });
}
