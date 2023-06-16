import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../models/shop_home_data_model.dart';
import '../../controller/shop_layout_cubit.dart';
import '../../controller/shop_layout_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (BuildContext context,state){},
        builder: (BuildContext context,state){
          return ConditionalBuilder(condition: ShopLayoutCubit.get(context).homeModel != null,
            builder: (BuildContext context) {return productBuilder(ShopLayoutCubit.get(context).homeModel) ; },
            fallback: (BuildContext context) =>const Center(child:CircularProgressIndicator(color: Colors.blue,) ),
          );
        },
      );
      },
    );
  }
}
Widget productBuilder(ShopHomeModel model){
  List<Widget> images= [
    customImage('https://img.freepik.com/free-vector/realistic-sale-background-with-balloons_23-2148857072.jpg?w=740&t=st=1686417016~exp=1686417616~hmac=a6cfe5760b264bc3ce2e394f3d43f655015ab83e161508902dbbea124ca86cb4'),
    customImage('https://img.freepik.com/premium-photo/3d-render-design-computer-online-technologic-store_274845-478.jpg?w=740'),
    customImage('https://img.freepik.com/premium-photo/shopping-cart-blue-background_601748-17300.jpg?w=740'),
    customImage('https://img.freepik.com/premium-psd/super-sale-promotion-social-media-3d-render-template-design-banner-template_502896-377.jpg?w=826'),
    customImage('https://img.freepik.com/premium-photo/pink-accessories-blue-background_41926-904.jpg?w=826')
  ];
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CarouselSlider(items: images,
                  options:CarouselOptions(
                    height: 40.h,
                    initialPage: 0,
                    autoPlay: true,
                    viewportFraction: 1.0
                  )),
            ),
          ),
          SizedBox(height: 1.h,),
          Text('Categories',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.blue),),
          ClipRRect(
            borderRadius: BorderRadius.circular(3.w),
            child: Image(image: NetworkImage('https://img.freepik.com/premium-photo/pink-accessories-blue-background_41926-904.jpg?w=826'),
              height: 20.h,
              width: 20.h,
              fit: BoxFit.fill,
            ),
          ),
          ///products
          Text('New products',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.blue),),
          GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 3.h),
            childAspectRatio: 1/(1.25),
            crossAxisSpacing: 2.w,
            mainAxisSpacing: 1.h,
            children: List.generate(model.data!.products.length, (index){
              return productGridItem(model.data!.products[index]);
            })),
        ],
      ),
    ),
  );
}
Widget productGridItem(ProductModel model){
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 1.h,right: 1.w,left: 1.w),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                    color: Colors.blue.shade100, //New
                    blurRadius: 25.0,
                    offset: const Offset(0, 10))
                  ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(
                            '${model.image}'),fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text('${model.name}',maxLines: 1),
                  ///bug!!
                  SizedBox(
                    height: 7.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          Text('${model.price.round()} EG',style: const TextStyle(color: Colors.blue),),
                          const Spacer(),
                          if(model.discount != 0)
                            Text('${model.oldPrice.round()} EG',style: const TextStyle(color: Colors.grey, )),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      ///favourites
      Padding(
        padding: EdgeInsets.all((1.5).w),
        child: CircleAvatar(
          radius: (4.5).w,
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.favorite_border,color: Colors.white,),),
      ),
    ],
  );
}
Widget customImage(String url){
  return Image(image: NetworkImage(url),fit: BoxFit.fill,);
}
