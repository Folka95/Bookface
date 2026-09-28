import 'package:flutter/material.dart';

class AppPage {
  final String title;
  final Widget page;
  final VoidCallback? onBack;

  const AppPage({required this.title, required this.page, this.onBack});
}
