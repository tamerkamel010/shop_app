import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components_Consts/Product_color_box.dart';
import 'package:shop_app/Components_Consts/custom_button.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_states.dart';
import 'package:sizer/sizer.dart';
import '../../../../models/shop_home_data_model.dart';
class ProductScreen extends StatelessWidget {
  final ProductModel model;
  const ProductScreen({super.key,required this.model});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (BuildContext context, ShopLayoutStates state) {  },
      builder: (BuildContext context, ShopLayoutStates state) {
        ShopLayoutCubit cubit = ShopLayoutCubit.get(context);
        return Sizer(
          builder: (BuildContext context, 
              Orientation orientation,
              DeviceType deviceType) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(-1.w,2.w),
                                blurRadius: 2.w,
                                color: Colors.blue.withOpacity(0.5)
                            ),
                            BoxShadow(
                                offset: Offset(1.w,2.w),
                                blurRadius: 2.w,
                                color: Colors.blue.withOpacity(0.5)
                            ),

                          ],
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w),bottomRight:Radius.circular(10.w) )
                      ),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.w,horizontal: 20.w),
                            child: CachedNetworkImage(imageUrl: model.image as String,),
                          ),
                        ),
                          ProductColorButton(
                            buttonColor: Colors.white,
                            child: Icon(Icons.chevron_left_rounded,size: 30.sp,),
                            onTap: (){Navigator.pop(context);},),

                        ],
                      ),
                    ),
                    SizedBox(height:2.w),
                    Text('Description',style: TextStyle(color: Colors.blue,fontSize: 7.w,fontWeight: FontWeight.bold),),
                    ///product description
                    Expanded(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.w),
                      child: SingleChildScrollView(child: Text('${model.description}',style: const TextStyle(fontWeight: FontWeight.bold),))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.w),
                      child: const Center(child: CustomButton(buttonText: 'Buy',buttonColor: Colors.blue,buttonTextColor: Colors.white,)),
                    )
                  ],
                ),
              ),
            );
          },
          
        );
      },
    );
  }
}
