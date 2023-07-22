import 'package:shop_app/models/favourites_model.dart';

abstract class ShopLayoutStates{
}
class ShopLayoutInitialState extends ShopLayoutStates{}

class ShopLayoutChangeNavBarState extends ShopLayoutStates{}

class ShopLayoutLoadState extends ShopLayoutStates{}

class ShopLayoutSuccessState extends ShopLayoutStates{}

class ShopLayoutErrorState extends ShopLayoutStates{}

class ShopGetCategoriesLoadingState extends ShopLayoutStates{}

class ShopGetCategoriesSuccessState extends ShopLayoutStates{}

class ShopGetCategoriesErrorState extends ShopLayoutStates{}

class ShopChangeFavouritesSuccess extends ShopLayoutStates{
  late FavouriteModel model;
  ShopChangeFavouritesSuccess(this.model);
}

class ShopChangeFavouritesError extends ShopLayoutStates{
}
class ShopChangeSuccess extends ShopLayoutStates{}

class ShopGetFavoritesLoadingState extends ShopLayoutStates{}

class ShopGetFavoritesSuccessState extends ShopLayoutStates{}

class ShopGetFavoritesErrorState extends ShopLayoutStates{}

class ShopGetProfileLoadingState extends ShopLayoutStates{}

class ShopGetProfileSuccessState extends ShopLayoutStates{}

class ShopGetProfileErrorState extends ShopLayoutStates{}
