import 'package:shop_app/models/shop_home_data_model.dart';

class CategoryProductsModel{
  late bool status;
  late CategoryProductsData? data;
  CategoryProductsModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data= CategoryProductsData.fromJson(json['data']);
  }
}
class CategoryProductsData{
  late List<ProductModel> products =[];
  CategoryProductsData.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });
  }
}