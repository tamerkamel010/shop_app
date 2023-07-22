class CategoryModel{
  late bool status;
  late CategoryData data;
  CategoryModel.fromJson(Map<String,dynamic> json){
    status= json['status'];
    data = CategoryData.fromJson(json['data']);
  }
}
class CategoryData{
  late List<CategoryDataModel> data = [];
  CategoryData.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element) {
      data.add(CategoryDataModel.fromJson(element));
    });
  }
}
class CategoryDataModel{
late int id;
late String name;
late String image;
CategoryDataModel.fromJson(Map<String,dynamic> json){
  id = json['id'];
  name = json['name'];
  image= json['image'];
}
}