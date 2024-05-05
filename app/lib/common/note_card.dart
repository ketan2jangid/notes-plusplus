import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteCard extends StatelessWidget {
  int counter;
  bool isSelected;
  final String title;
  final String body;
  NoteCard(
      {super.key,
      required this.title,
      required this.body,
      this.isSelected = false,
      this.counter = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? buttonWhite : Colors.grey.shade800,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: titleStyle,
                // maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (body.isNotEmpty) ...[
            const Gap(6),
            Expanded(
              flex: 5,
              child: Text(
                body,
                style: bodyStyle,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]
        ],
      ),
    );
  }
}

final titleStyle = GoogleFonts.jost(
    color: buttonWhite, fontSize: 20, fontWeight: FontWeight.w600);

final bodyStyle = GoogleFonts.jost(
    color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.w400);
