import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:sizer/sizer.dart';
import '../../controller/shop_layout_cubit.dart';
import '../../controller/shop_layout_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType)=>BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
          listener: (BuildContext context,state) {},
        builder: (BuildContext context, state){
            var cubit = ShopLayoutCubit.get(context);
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 2.w),
                child: ListView.separated(itemBuilder: (BuildContext context,int index)=>categoryItem(cubit.categoryModel.data.data[index]),
                    separatorBuilder: (BuildContext context,int index)=>SizedBox(height: 5.w,),
                    itemCount: cubit.categoryModel.data.data.length),
            );
        },
      ),
    );
  }

}
Widget categoryItem(CategoryDataModel model){
  return Row(
    children: [
      Container(
        height: 20.h,
        width: 38.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.h),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: CachedNetworkImage(imageUrl:model.image,fit: BoxFit.fill,),
        ),

      ),
      SizedBox(width: 2.w,),
      Text(model.name,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 13.sp),),
      const Spacer(),
      CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 5.w,
        child: IconButton(onPressed: (){},
            color: Colors.blue,
            icon: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 15.sp,)),
      ),
    ],
  );
}
