import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';

notifyUser(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: buttonWhite,
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}
