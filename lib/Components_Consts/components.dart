import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'consts.dart';
Widget OnBoardItem({required IconData iconData, required String text}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 100,
        ),
        Text(
          text,
          style: GoogleFonts.aleo(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        )
      ],
    );

void NavigateAndDelete(context, Widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false);
}


///return type in onpressed and Method must be identicals.
