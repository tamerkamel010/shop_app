import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

Future<bool?> flutterToast(
    {
  required String message,
  Color backgroundColor=Colors.red,
  double? fontSize,
  Color fontColor = Colors.white
} ){
  return Fluttertoast.showToast(
      msg: message,
      backgroundColor: backgroundColor,
      fontSize: fontSize?? 10.sp,
      textColor: fontColor
  );
}