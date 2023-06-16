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
void NavigateTo(context, Widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ));
}
void NavigateAndDelete(context, Widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false);
}
Widget Custom_Text_Form_Field({
  required TextEditingController controller,
  required IconData preFixIcon,
  TextInputType keyboardType = TextInputType.text,
  bool IsPasswordField = false,
  bool isPasswordShown = false,
  Function()? passwordFun,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: Icon(preFixIcon),
        ///switch icon
        suffixIcon: IsPasswordField
            ? IconButton(
                onPressed: () => passwordFun,
                icon: isPasswordShown
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              )
            : null,
      ),
      obscureText: isPasswordShown,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'field must not be empty';
        }
        return null;
      },
    );
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText,hintText;
  final Color? labelTextColor,borderColor,textFieldColor;
  final double? labelTextSize,verticalSpace;
  final double borderRadius;
  final FontWeight? hintTextWeight;
  final Color hintTextColor;
  final String? Function(String value)? validate;
  final bool? isPasswordField, isPasswordShown;
  final Function()? passwordFun;
  final Function(String? value)? onSubmit;
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
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: (value)=> onSubmit!(value),
      style: TextStyle(color: Colors.blue,decoration: TextDecoration.none),
      decoration: InputDecoration(
        filled: true,
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
///return type in onpressed and Method must be identicals.
