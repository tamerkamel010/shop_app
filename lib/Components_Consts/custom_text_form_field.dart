import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText,hintText;
  final Color? labelTextColor,borderColor,textFieldColor,iconColor;
  final double? labelTextSize,verticalSpace;
  final double borderRadius;
  final FontWeight? hintTextWeight;
  final Color hintTextColor;
  final String? Function(String value)? validate;
  final bool? isPasswordField, isPasswordShown;
  final Function()? passwordFun;
  final Function(String? value)? onChange;
  final Function(String? value)? onSubmit;
  final IconData? prefixIcon;
  final bool readOnly ;
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.labelTextSize = 15,
    this.labelTextColor = Colors.blue,
    this.verticalSpace = 10,
    this.borderRadius = 10,
    this.borderColor = Colors.blue,
    this.hintText,
    this.isPasswordField = false,
    this.isPasswordShown = false,
    required this.controller,
    this.passwordFun,
    this.validate,
    this.textFieldColor = Colors.white,
    this.hintTextWeight = FontWeight.bold,
    this.hintTextColor = Colors.blue,
    this.onSubmit,
    this.onChange,
    this.prefixIcon,
    this.iconColor= Colors.blue,
    this.readOnly = false
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onFieldSubmitted: (value)=> onSubmit!(value),
      onChanged: (value)=> onChange!(value),
      style: const TextStyle(color: Colors.blue,decoration: TextDecoration.none,fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(prefixIcon,color:iconColor,),
        fillColor: textFieldColor,
        hintStyle: TextStyle(fontWeight: hintTextWeight,color: hintTextColor.withOpacity(0.6)),
        hintText: hintText,
        contentPadding:EdgeInsets.all((2.5).h) ,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        ///switch icon
        suffixIcon: isPasswordField!
            ? InkWell(
          ///() is Mandatory after the function call
          onTap: (){passwordFun!();},
          child: isPasswordShown!
              ? const Icon(Icons.visibility_outlined,color: Colors.blue,)
              : const Icon(Icons.visibility_off_outlined,color: Colors.red,),
        )
            : null,
      ),
      obscureText: isPasswordShown!,
      validator: (String? value)=> validate!(value!),
    );
  }

}