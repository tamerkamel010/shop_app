class ShopHomeModel{
   bool? status;
   ShopDataModel? data;
   ShopHomeModel.fromJson(Map<String?,dynamic>? json){
     status =json!['status'];
     data = ShopDataModel.fromJson(json['data']);

   }
}
class ShopDataModel{
   List<BannerModel> banners =[];
   List<ProductModel> products =[];
   ShopDataModel.fromJson(Map<String?,dynamic> json) {
     json['banners'].forEach((element){banners.add(BannerModel.fromJson(element));});
     json['products'].forEach((element){products.add(ProductModel.fromJson(element));});

   }
}
class BannerModel{
 int? id;
 String? image;
 BannerModel({this.id,this.image});
 BannerModel.fromJson(Map<String?,dynamic> json){
   id=json['id'];
   image = json['image'];
 }
 
}
class ProductModel {
 int? id;
 dynamic price;
 dynamic oldPrice;
 dynamic discount;
 String? image;
 String? name;
 bool? inFavorites;
 bool? inCart;
 ProductModel({this.id,this.image,this.discount,this.inCart,this.inFavorites,this.name,this.oldPrice,this.price});
 ProductModel.fromJson(Map<String,dynamic> json){
   id = json['id'];
   price = json['price'];
   oldPrice = json['old_price'];
   discount = json['discount'];
   name = json['name'];
   image = json['image'];
   inFavorites = json['in_favorites'];
   inCart = json['in_cart'];
 }
}
