import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockButton extends StatefulWidget {
  final void Function()? onPressed;
  final String text;
  const BlockButton({super.key, required this.onPressed, required this.text});

  @override
  State<BlockButton> createState() => _BlockButtonState();
}

class _BlockButtonState extends State<BlockButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: buttonWhite,
        backgroundColor: buttonWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ), 
      child: Text(
        widget.text,
        style: GoogleFonts.jost(
          color: appBackgroundColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}