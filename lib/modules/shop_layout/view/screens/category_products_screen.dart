import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_states.dart';
import 'package:shop_app/modules/shop_layout/view/screens/home_screen.dart';
import 'package:sizer/sizer.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final String? categoryImage;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
    this.categoryImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (BuildContext context, ShopLayoutStates state) {},
      builder: (BuildContext context, ShopLayoutStates state) {
        ShopLayoutCubit cubit = ShopLayoutCubit.get(context);
        return Sizer(
            builder: (BuildContext context, Orientation orientation,
                    DeviceType deviceType) =>
                Scaffold(
                  body: state is ShopCategoryProductsLoadState
                      ? Center(
                          child: SizedBox(
                              width: 10.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LinearProgressIndicator(),
                                  SizedBox(
                                    height: 1.w,
                                  ),
                                  LinearProgressIndicator(),
                                  SizedBox(
                                    height: 1.w,
                                  ),
                                  LinearProgressIndicator(),
                                  SizedBox(
                                    height: 1.w,
                                  ),
                                  LinearProgressIndicator(),
                                ],
                              )))
                      : CustomScrollView(
                          slivers: <Widget>[
                            SliverAppBar(
                              leading: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.chevron_left_rounded,
                                  color: Colors.blue,
                                  size: 25.sp,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              floating: false,
                              pinned: true,
                              expandedHeight: 60.w,
                              flexibleSpace: FlexibleSpaceBar(
                                centerTitle: true,
                                title: Text(
                                  categoryName,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                background: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.w),
                                    child: Image(
                                      image: CachedNetworkImageProvider(
                                          categoryImage!),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.9,
                                        mainAxisSpacing: 2.w,
                                        crossAxisSpacing: 2.w,
                                        crossAxisCount: 2),
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) => cubit
                                                .categoryProductsModel!
                                                .data!
                                                .products[index] !=null
                                        ? productGridItem(
                                            cubit.categoryProductsModel!.data!
                                                .products[index],
                                            context)
                                        : null,
                                    childCount: cubit.categoryProductsModel
                                        ?.data?.products.length))
                          ],
                        ),
                ));
      },
    );
  }
}
