import 'package:flutter/material.dart';
Widget onBoardItem({required String image, required String text}) =>
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image),fit: BoxFit.cover)
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "janna")
          )
        ],
      ),
    );

void navigateAndDelete(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false);
}


///return type in on pressed and Method must be identical.
