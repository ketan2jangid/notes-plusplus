import 'package:flutter/material.dart';

notifyUser(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.grey.shade900,
      content: Text(message, style: TextStyle(color: Colors.white),),
    ),
  );
}
