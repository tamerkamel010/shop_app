import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components_Consts/components.dart';
import 'package:shop_app/Components_Consts/custom_button.dart';
import 'package:shop_app/modules/login/view/login_screen.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../Components_Consts/profile_item_card.dart';
import '../../../../network/local/shared_preferences.dart';
import '../../controller/shop_layout_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);
    cubit.userNameController.text = cubit.profileModel.data!.name?.toUpperCase() as String;
    cubit.emailController.text = cubit.profileModel.data!.email as String;
    cubit.phoneController.text = cubit.profileModel.data!.phone as String;


    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Sizer(
          builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) =>
              cubit.profileModel != null ? SingleChildScrollView(
                child: Column(
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
                    ),///camera icon
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.w,
                      ),
                      profileItem(
                          cubit.userNameController,
                          Icons.person_outline,
                        onTap: (){
                        cubit.changeProfileItem1();
                        debugPrint(cubit.profileItem1.toString());
                      },
                          readOnly: cubit.profileItem1,

                          ),
                      SizedBox(
                        height: 5.w,
                      ) ,
                      profileItem(
                          cubit.emailController,
                          Icons.alternate_email,
                        onTap: (){
                          cubit.changeProfileItem2();
                          debugPrint(cubit.profileItem2.toString());
                        },
                        readOnly: cubit.profileItem2
                      ) ,
                      SizedBox(
                        height: 5.w,
                      ) ,
                      profileItem(
                          cubit.phoneController,
                          Icons.phone_android_rounded,
                        onTap: (){
                          cubit.changeProfileItem3();
                          debugPrint(cubit.profileItem3.toString());
                        },
                        readOnly: cubit.profileItem3
                      ) ,
                      SizedBox(
                        height: 10.w,
                      ),
                      SizedBox(
                        height: 20.w,
                        child: Row(
                          children: [
                            Expanded(child: CustomButton(
                              buttonColor: Colors.blue,
                              buttonText: 'Update',
                              buttonTextColor: Colors.white,
                              borderRadius: 3.w,
                              buttonWidth: 5.w,
                              buttonHeight: 4.w,
                            )),
                            SizedBox(width: 2.w,),
                            Expanded(child: CustomButton(
                                buttonColor: Colors.white,
                                onTap: (){
                                  SharedPref.signOut(cubit.profileModel.data!.token as String);
                                  NavigateAndDelete(context, const LoginScreen());
                                },
                                borderRadius: 3.w,
                                buttonText: 'Log out',
                                buttonTextColor: Colors.blue,
                                buttonWidth: 5.w,
                                buttonHeight: 4.w,
                            )),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
              ) : const CircularProgressIndicator(),
        );
      },
    );
  }
}
