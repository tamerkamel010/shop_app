import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final double borderRadius, buttonTextSize;
  final Color buttonColor;
  final String buttonText;
  final Color? buttonTextColor;
  final FontWeight buttonTextWeight;
  final double buttonWidth;
  final double buttonHeight;
  final double elevation;



  const CustomButton({
    super.key,
    this.onTap,
    this.borderRadius = 50,
    this.buttonColor = Colors.white,
    required this.buttonText,
    this.buttonTextSize = 18,
    this.buttonTextColor,
    this.buttonTextWeight = FontWeight.bold,
    this.buttonHeight = 20,
    this.buttonWidth = 130,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
              vertical: (buttonHeight),
              horizontal: (buttonWidth)
          )),
      child: Text(
        buttonText,
        style: TextStyle(
            fontSize: buttonTextSize,
            color: buttonTextColor,
            fontWeight: buttonTextWeight),
      ),
    );
  }
}