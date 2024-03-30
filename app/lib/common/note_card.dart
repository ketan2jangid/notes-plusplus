import 'package:app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteCard extends StatelessWidget {
  int counter;
  bool isSelected;
  final String title;
  final String body;
  NoteCard({super.key, required this.title, required this.body, this.isSelected = false, this.counter = 0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade800, width: 2),
              borderRadius: BorderRadius.circular(24),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: Text(title, style: titleStyle, maxLines: 2, overflow: TextOverflow.ellipsis,),),
              const Gap(12),
              Expanded(flex: 3, child: Text(body, style: bodyStyle, maxLines: 4, overflow: TextOverflow.ellipsis,),),
            ],
          ),
        ),
        if (isSelected)
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.7),
              border: Border.all(
                  color: Colors.red.shade700, width: 2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(Icons.delete_outline_rounded, color: buttonWhite, size: 36,),
          )
      ],
    );
  }
}

final titleStyle = GoogleFonts.jost(
    color: buttonWhite,
    fontSize: 20,
    fontWeight: FontWeight.w600
);

final bodyStyle = GoogleFonts.jost(
    color: Colors.grey.shade400,
    fontSize: 14,
    fontWeight: FontWeight.w400
);


