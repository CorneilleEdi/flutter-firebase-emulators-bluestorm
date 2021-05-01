import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ScaffoldExtension on BuildContext {
  showSuccessSnackbar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: Colors.green.shade500,
      ),
    );
  }

  showErrorSnackbar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: Colors.red.shade500,
      ),
    );
  }
}
