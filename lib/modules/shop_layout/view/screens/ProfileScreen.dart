import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../Components_Consts/custom_text_form_field.dart';
import '../../../../Components_Consts/profile_item_card.dart';
import '../../controller/shop_layout_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);
    cubit.userNameController.text =
        cubit.profileModel.data!.name?.toUpperCase() as String;
    cubit.emailController.text = cubit.profileModel.data!.email as String;
    cubit.phoneController.text = cubit.profileModel.data!.phone as String;

    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Sizer(
          builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) =>
              Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 50.w,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.blue, width: 1.w),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                '${ShopLayoutCubit.get(context).profileModel.data!.image}'))),
                  ),

                  ///camera icon
                  Positioned(
                    right: 30.w,
                    bottom: -(0.02).w,
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue, width: 1.w),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.w,
                      ) ,
                      profileItem(cubit.userNameController, Icons.person_outline),
                      SizedBox(
                        height: 5.w,
                      ) ,
                      profileItem(cubit.emailController, Icons.alternate_email) ,
                      SizedBox(
                        height: 5.w,
                      ) ,
                      profileItem(cubit.phoneController, Icons.phone_android_rounded) ,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
