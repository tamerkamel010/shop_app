import 'package:shop_app/models/shop_home_data_model.dart';

class GetFavourites{
  late bool status;
  late FavData dataOut;
  GetFavourites.fromJson(Map<String,dynamic> json){
    status =json['status'];
    dataOut = FavData.fromJson(json['data']);
  }
}
class FavData{
  late List<FavProduct> dataIn=[];
  FavData.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      dataIn.add(FavProduct.fromJson(element));
    });
  }
}
class FavProduct{
  late int favProductId;
  late ProductModel product;
  FavProduct.fromJson(Map<String,dynamic> json){
    favProductId = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}
/*
class ProductModel{
  late int id;
  late double price;
  late double oldPrice;
  late double discount;
  late String image;
  late String name;
  ProductModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
  }
}*/
