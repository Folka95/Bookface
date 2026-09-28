import 'package:flutter/cupertino.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({super.key, required this.title, required this.subTitle});
final String title;
final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(subTitle),
        SizedBox(height: 30,),
      ],
    );
  }
}
