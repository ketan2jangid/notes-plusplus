import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget noConnectionDialog() {
  return AlertDialog(
    backgroundColor: appBackgroundColor,
    icon: Icon(
      Icons.wifi_off_rounded,
      color: Colors.red.shade700,
    ),
    title: Text(
      "No Internet",
      style: GoogleFonts.jost(
        color: buttonWhite,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
