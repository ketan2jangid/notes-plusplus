import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';

// TODO: Make custom loader - square toppling
showLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(
        color: buttonWhite,
        strokeWidth: 2.0,
      ),
    ),
  );
}

hideLoader(BuildContext context) {
  Navigator.pop(context);
}
