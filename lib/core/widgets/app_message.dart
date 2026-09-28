import 'package:flutter/material.dart';

enum AppMessageType {
  success,
  failed,
  warning,
  error,
  information,
}

class AppMessage {
  static void show(
      BuildContext context, {
        required String message,
        AppMessageType type = AppMessageType.information,
      }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _getIcon(type),
              color: Colors.white,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(message),
            ),
          ],
        ),

        backgroundColor: _getColor(type),

        behavior: SnackBarBehavior.floating,

        duration: const Duration(
          seconds: 3,
        ),
      ),
    );
  }

  static IconData _getIcon(AppMessageType type) {
    switch (type) {
      case AppMessageType.success:
        return Icons.check_circle;

      case AppMessageType.failed:
        return Icons.cancel;

      case AppMessageType.warning:
        return Icons.warning;

      case AppMessageType.error:
        return Icons.error;

      case AppMessageType.information:
        return Icons.info;
    }
  }

  static Color _getColor(AppMessageType type) {
    switch (type) {
      case AppMessageType.success:
        return Colors.green;

      case AppMessageType.failed:
        return Colors.orange;

      case AppMessageType.warning:
        return Colors.amber;

      case AppMessageType.error:
        return Colors.red;

      case AppMessageType.information:
        return Colors.blue;
    }
  }
}