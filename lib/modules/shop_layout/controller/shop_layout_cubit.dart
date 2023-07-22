import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/remote/dio.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/shop_home_data_model.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_states.dart';
import 'package:shop_app/modules/shop_layout/view/screens/cart.dart';
import 'package:shop_app/modules/shop_layout/view/screens/favourites.dart';
import 'package:shop_app/modules/shop_layout/view/screens/home_screen.dart';
import 'package:shop_app/modules/shop_layout/view/screens/categories_screen.dart';
import 'package:shop_app/modules/shop_layout/view/screens/ProfileScreen.dart';
import 'package:shop_app/network/local/shared_preferences.dart';

import '../../../models/categories_model.dart';
import '../../../models/get_favorites_model.dart';
import '../../../network/remote/endpoints.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit():super(ShopLayoutInitialState());
  static ShopLayoutCubit get(context)=> BlocProvider.of(context);
  int currentIndex = 0;
  dynamic token = SharedPref.get(key: 'token');
  dynamic homeModel;
  late TextEditingController searchController = TextEditingController();
  late CategoryModel categoryModel;
  FavouriteModel? favouriteModel;
  late GetFavourites getFavouritesModel;
  late LoginModel profile;

  List<Widget> screens=const [
    HomeScreen(),
    CategoriesScreen(),
    Cart(),
    FavouritesScreen(),
    ProfileScreen(),
  ];
  List<String> screensTitles = const [
    'Home',
    'Categories',
    'Cart',
    'Favourites',
    'Settings'
  ];
  Map<int?,bool?> favourites={};
  dynamic favKey = GlobalKey();
  void navigateTo(context, Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }
  void changeIndex(index){
    currentIndex = index;
    emit(ShopLayoutChangeNavBarState());
  }
  getHomeData(){
    emit(ShopLayoutLoadState());
    DioHelper.getData(url: Home,token: token,lang: 'en').then((value){
      homeModel = ShopHomeModel.fromJson(value.data);
      homeModel.data!.products.forEach((element) {
        favourites.addAll({element.id:element.inFavorites});
      });
      emit(ShopLayoutSuccessState());
    }).catchError((error){
      print(error);
      emit(ShopLayoutErrorState());
    });
  }
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
  getFavoritesData(){
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: Favorites,token: token,lang: 'en').then((value){
      getFavouritesModel = GetFavourites.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error){
      print(error);
      emit(ShopGetFavoritesErrorState());
    });
  }
  goToCategories(){
    currentIndex = 1;
    emit(ShopLayoutChangeNavBarState());
  }
  changeFavourites(int? productId){
    favourites[productId]=!favourites[productId]!;
    emit(ShopChangeSuccess());
    DioHelper.postData(
      url: Favorites,
      data: {'product_id':productId},token: token,lang: 'en'
    ).then((value){
      favouriteModel = FavouriteModel.fromJson(value.data);
      print(favouriteModel!.message);
      print(favouriteModel!.status);
      if(!favouriteModel!.status){
        favourites[productId]=!favourites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ShopChangeFavouritesSuccess(favouriteModel!));
    }).catchError((error){
      print(error.toString());
      favourites[productId]=!favourites[productId]!;
      emit(ShopChangeFavouritesError());
  }
    );
  }
  getProfile(){
    emit(ShopGetProfileLoadingState());
    DioHelper.getData(url: Profile,token: token,lang: 'en').then((value){
      profile= LoginModel.fromJson(value.data);
      print(profile.data!.phone);
      emit(ShopGetProfileSuccessState());
    }).catchError((error){
      print(error);
      emit(ShopGetProfileErrorState());
    });
  }
}
