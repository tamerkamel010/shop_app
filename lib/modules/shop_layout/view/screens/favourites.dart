import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favorites_model.dart';
import 'package:shop_app/models/shop_home_data_model.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_states.dart';
import 'package:sizer/sizer.dart';

import 'home_screen.dart';
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},
      builder:(context,state){
         var cubit = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.getFavouritesModel.dataOut.dataIn.isNotEmpty,
          builder: (BuildContext context)=>ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.w),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index)=>SizedBox(
              height: 30.h,
              child: productGridItem(
                  ShopLayoutCubit.get(context).getFavouritesModel.dataOut.dataIn[index].product,context
              ),
            ),
            separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 10.w,),
            itemCount: ShopLayoutCubit.get(context).getFavouritesModel.dataOut.dataIn.length,
          ),
          fallback: (BuildContext context)=> const Center(child: CircularProgressIndicator(color: Colors.blue,)),
        );
      } ,
    );
  }
}

