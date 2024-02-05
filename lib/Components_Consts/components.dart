import 'package:flutter/material.dart';

Widget onBoardItem({required String image, required String text}) => Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.contain)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
            child: Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                    fontFamily: "janna")),
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
