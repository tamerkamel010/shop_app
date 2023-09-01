import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'custom_text_form_field.dart';

class ProfileItem extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final IconData? prefixIcon;

  const ProfileItem({
    super.key,
    required this.controller,
    this.icon = Icons.edit_outlined,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
              shadowColor: Colors.blue.shade400,
              elevation: 3,
              child: CustomTextFormField(
                controller: controller,
                readOnly: true,
                prefixIcon: prefixIcon,
              )),
        ),
        CircleAvatar(
          radius: 6,
          backgroundColor: Colors.blue,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
Widget profileItem(
    TextEditingController controller,
    IconData prefixIcon,
    {
      bool readOnly = true,
      dynamic Function()? onTap,
    }
    )=>Row(
  children: [
    Expanded(
      child: Card(
          shadowColor: Colors.blue.shade400,
          elevation: 3,
          child: CustomTextFormField(
            controller: controller,
            readOnly: readOnly,
            prefixIcon: prefixIcon,

          )),
    ),
      InkWell(
        onTap: onTap,
        child: readOnly == true? CircleAvatar(
        radius: 6.w,
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.edit_outlined,
          color: Colors.white,
        ),) : const SizedBox(width: 0.000001,),
      ),
  ],
);
