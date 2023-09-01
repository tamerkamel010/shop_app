import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class ProductColorButton extends StatelessWidget {
  final Color buttonColor;
  final void Function()? onTap;
  final Widget? child;
  const ProductColorButton({
    super.key,
    required this.buttonColor,
    this.onTap,
    this.child,

  });
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType)=>InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w,horizontal: 4.w),
        child: Container(
          alignment: Alignment.center,
          height: 14.w,
          width: 14.w,
          decoration: BoxDecoration(
              color: buttonColor,
              boxShadow: [
                BoxShadow(
                    offset: Offset(-(0.2).w,(0.5).w),
                    blurRadius: 2.w,
                    color: Colors.blue
                ),
              ],
              borderRadius: BorderRadius.circular(2.w)
          ),
          child: child,
        ),
      ),
    ),);
  }
}
