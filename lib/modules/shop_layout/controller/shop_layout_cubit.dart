import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/remote/dio.dart';
import 'package:shop_app/models/shop_home_data_model.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_states.dart';
import 'package:shop_app/modules/shop_layout/view/screens/cart.dart';
import 'package:shop_app/modules/shop_layout/view/screens/favourites.dart';
import 'package:shop_app/modules/shop_layout/view/screens/home_screen.dart';
import 'package:shop_app/modules/shop_layout/view/screens/products.dart';
import 'package:shop_app/modules/shop_layout/view/screens/settings.dart';
import 'package:shop_app/network/local/shared_preferences.dart';

import '../../../models/categories_model.dart';
import '../../../network/remote/endpoints.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit():super(ShopLayoutInitialState());
  static ShopLayoutCubit get(context)=> BlocProvider.of(context);
  int currentIndex = 0;
  dynamic token = SharedPref.get(key: 'token');
  dynamic homeModel;
  late CategoryModel categoryModel;

  List<Widget> screens=const [
    HomeScreen(),
    ProductsScreen(),
    Cart(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  void changeIndex(index){
    currentIndex = index;
    emit(ShopLayoutChangeNavBarState());
  }
  getHomeData(){
    emit(ShopLayoutLoadState());
    DioHelper.getData(url: Home,token: token,lang: 'en').then((value){
      homeModel = ShopHomeModel.fromJson(value.data);
      print(homeModel.data!.banners[0].id);
      emit(ShopLayoutSuccessState());
    }).catchError((error){
      print(error);
      emit(ShopLayoutErrorState());
    });
  }
  ///not finished yet
  getCategoriesData(){
    emit(ShopGetCategoriesLoadingState());
    DioHelper.getData(url: GetCategories,token: token,lang: 'en').then((value){
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel.data.toString());
      emit(ShopGetCategoriesSuccessState());
    }).catchError((error){
      print(error);
      emit(ShopGetCategoriesErrorState());
    });
  }
}