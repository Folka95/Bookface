
import 'package:flutter/material.dart';

class HaveAccountOrNotWidget extends StatelessWidget {
  const HaveAccountOrNotWidget({super.key, required this.text, required this.actionText, required this.onTap});
final String text;
final GestureTapCallback onTap;
final String actionText;
  @override
  Widget build(BuildContext context) {
    return            Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        SizedBox(width: 5),
        InkWell(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              color: Colors.blueAccent,

              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
