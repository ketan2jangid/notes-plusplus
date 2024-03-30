import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Label extends StatelessWidget {
  final String text;
  const Label({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.agdasima(
        color: buttonWhite,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
