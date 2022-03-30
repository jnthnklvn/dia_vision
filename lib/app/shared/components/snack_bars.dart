import 'package:flutter/material.dart';

class SnackBars {
  static SnackBar error(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    );
  }

  static SnackBar confirmation(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    );
  }
}
