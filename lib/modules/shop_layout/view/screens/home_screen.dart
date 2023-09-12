import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components_Consts/navigate_and_finish.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/shop_layout/view/screens/product_screen.dart';
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
          return ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).homeModel != null,
            builder: (BuildContext context) {
              return productBuilder(ShopLayoutCubit.get(context).homeModel,ShopLayoutCubit.get(context).categoryModel,context) ; },
            fallback: (BuildContext context) =>const Center(child:CircularProgressIndicator(color: Colors.blue,) ),
          );
        },
      );
      },
    );
  }
}
Widget productBuilder(ShopHomeModel model,CategoryModel categoryModel, BuildContext context){
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
          ///carousel images
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CarouselSlider(
                  items: images,
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
          SizedBox(
          height: 25.h,
              child: categoryListView(categoryModel.data.data)),
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
              return productGridItem(model.data!.products[index],context);
            })),
        ],
      ),
    ),
  );
}
Widget productGridItem(ProductModel model,context){
  return InkWell(
    onTap: (){
      navigateTo(context, ProductScreen(model: model));
    },
    child: Stack(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Padding(
                              padding:EdgeInsets.symmetric(vertical: 1.h),
                              child: Center(child: CachedNetworkImage(imageUrl: '${model.image}',fit: BoxFit.fill,))
                            ),
                            if(model.price != model.oldPrice)
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 3.h,
                                  width: 6.h,
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade300,
                                      borderRadius: BorderRadius.circular(1.w)
                                  ),
                                  child: Center(child: Text('${model.discount} % -',style: TextStyle(color: Colors.white,fontSize: 8.sp,fontWeight: FontWeight.bold),),),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Text('${model.name}',maxLines: 1),
                    ///prices
                    SizedBox(
                      height: 7.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          children: [
                            Text('${model.price.round()} EG',style: TextStyle(color: Colors.blue,fontSize: 12.sp),),
                            SizedBox(width: 2.w,),
                            if(model.discount != 0)
                              Text('${model.oldPrice.round()} EG',
                                  style:TextStyle(color: Colors.grey,
                                    fontSize: 10.sp,
                                    textBaseline: TextBaseline.alphabetic,
                                  )),

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
        ///favourites icon
        Padding(
          padding: EdgeInsets.all((1.5).w),
          child: InkWell(
            onTap: (){
               ShopLayoutCubit.get(context).changeFavourites(model.id);
               print(model.inFavorites);
            },
            child: CircleAvatar(
              radius: (4.5).w,
              backgroundColor: Colors.blue,
              child: Icon(
                (ShopLayoutCubit.get(context).favourites[model.id]??false) ?Icons.favorite :Icons.favorite_border,color: Colors.white,),),
          ),
        ),
      ],
    ),
  );
}
Widget customImage(String url){
  return CachedNetworkImage(imageUrl: url,fit: BoxFit.fill,);
}
Widget categoryListView(List<CategoryDataModel> listOfModel){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.w),
    child: SizedBox(
      child: ListView.separated(
        scrollDirection:Axis.horizontal ,
        itemBuilder: (BuildContext context, int index){
          if(index == 3){
            ///see all box
            return InkWell(
              onTap: (){
                ShopLayoutCubit.get(context).goToCategories();
              },
              child: Container(
                height: 25.h,
                width: 25.h,
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(2.h)
                ),
                child: Center(child: Text('See all',style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold,),)),
              ),
            );
          }else{
            ///category item
            return ClipRRect(
              borderRadius: BorderRadius.circular(3.w),
              child: SizedBox(
                height: 25.h,
                width: 25.h,
                child: CachedNetworkImage(
                  imageUrl: listOfModel[index].image,
                  fit: BoxFit.fill,
                ),
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 2.w,),
        itemCount: 4,
      ),
    ),
  );
}
