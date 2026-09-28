import 'package:blog_app/core/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key, required this.widget,required this.appTopBar});
final Widget widget;
final AppTopBar appTopBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appTopBar,
      body:  Stack(
        children: [
          Image.asset("assets/images/bg.png",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          widget,
        ],
      ),

    );

  }
}
