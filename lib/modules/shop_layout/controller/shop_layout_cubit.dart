import 'package:cached_network_image/cached_network_image.dart';
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
  late LoginModel profileModel;
  ///profile controllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ///
  List<Widget> screens=const [
    HomeScreen(),
    CategoriesScreen(),
    Cart(),
    FavouritesScreen(),
    ProfileScreen(),
  ];
  List<String> screensTitles = [
    'Home',
    'Categories',
    'Cart',
    'Favourites',
    'Profile'
  ];
  bool profileItem1 = true;
  bool profileItem2 = true;
  bool profileItem3 = true;

  Map<int?,bool?> favourites={};
  dynamic favKey = GlobalKey();

  void changeProfileItem1(){
    profileItem1= false;
    emit(ShopProfileItemChangeState());
  }
  void changeProfileItem2(){
    profileItem2= false;
    emit(ShopProfileItemChangeState());
  }
  void changeProfileItem3(){
    profileItem3= false;
    emit(ShopProfileItemChangeState());
  }
  List<Widget>? carouselSliderImages(List<String>? images){
    List<Widget>? carouselImages;
    for(int i=0;i<images!.length;i++){
      carouselImages!.add(CachedNetworkImage(imageUrl: images[i],));
    }
    return carouselImages;
  }

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
    DioHelper.getData(url: home,token: token,lang: 'en').then((value){
      homeModel = ShopHomeModel.fromJson(value.data);
      homeModel.data!.products.forEach((element) {
        favourites.addAll({element.id:element.inFavorites});
      });
      emit(ShopLayoutSuccessState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(ShopLayoutErrorState());
    });
  }
  getCategoriesData(){
    emit(ShopGetCategoriesLoadingState());
    DioHelper.getData(url: getCategories,token: token,lang: 'en').then((value){
      categoryModel = CategoryModel.fromJson(value.data);
      debugPrint(categoryModel.data.toString());
      emit(ShopGetCategoriesSuccessState());
    }).catchError((error){
      debugPrint(error);
      emit(ShopGetCategoriesErrorState());
    });
  }
  getFavoritesData(){
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: favorites,token: token,lang: 'en').then((value){
      getFavouritesModel = GetFavourites.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error){
      debugPrint(error);
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
      url: favorites,
      data: {'product_id':productId},token: token,lang: 'en'
    ).then((value){
      favouriteModel = FavouriteModel.fromJson(value.data);
      debugPrint(favouriteModel!.message);
      debugPrint(favouriteModel!.status.toString());
      if(!favouriteModel!.status){
        favourites[productId]=!favourites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ShopChangeFavouritesSuccess(favouriteModel!));
    }).catchError((error){
      debugPrint(error.toString());
      favourites[productId]=!favourites[productId]!;
      emit(ShopChangeFavouritesError());
  }
    );
  }
  getProfile(){
    emit(ShopGetProfileLoadingState());
    DioHelper.getData(url: profile,token: token,lang: 'en').then((value){
      profileModel= LoginModel.fromJson(value.data);
      debugPrint("getting profile successfully");
      debugPrint(profileModel.data!.phone);
      emit(ShopGetProfileSuccessState());
    }).catchError((error){
      debugPrint(error);
      emit(ShopGetProfileErrorState());
    });
  }
  updateProfile(){}

}
