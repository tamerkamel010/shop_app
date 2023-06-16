import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_states.dart';
import 'package:sizer/sizer.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (BuildContext context,state){},
      builder: (BuildContext context,state){
        var cubit = ShopLayoutCubit.get(context);
        return Sizer(
          builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {return Scaffold(
            appBar: AppBar(
              title: const Text("Salla",style: TextStyle(color: Colors.blue),),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: (0.9).w),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 5.w,
                    child: IconButton(onPressed: (){},
                        color: Colors.blue,
                        icon: Icon(Icons.search_outlined,color: Colors.white,size: 15.sp,)),
                  ),
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              buttonBackgroundColor: Colors.blue,
              color: Colors.blue,
              backgroundColor: Colors.white,
              index: cubit.currentIndex,
              height: 70.0,
              animationDuration:  const Duration(milliseconds: 300),
              onTap: (index){
                cubit.changeIndex(index);
              },
              items: const <Widget>[
                Icon(Icons.home_outlined,color: Colors.white,),
                Icon(Icons.window_outlined,color: Colors.white),
                Icon(Icons.shopping_cart_outlined,color: Colors.white),
                Icon(Icons.favorite_outline_rounded,color: Colors.white),
                Icon(Icons.settings,color: Colors.white),
              ],),
          );},
        ); },
    );
  }
}
