import 'package:dio/dio.dart';
class DioHelper{
  static Dio dio = Dio(BaseOptions(
  baseUrl:'https://student.valuxapps.com/api/',
  headers: {'Content-Type':'application/json',
  },
  receiveDataWhenStatusError: true
  ));

  static Future<Response> getData({required String url,Map<String,dynamic>? queries,String? token,String lang='ar'})async{
    dio.options.headers = {
      'Authorization':token,
      'lang':lang,
    };
    return await dio.get(url,
      queryParameters: queries,
    );
  }
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String,dynamic>? queries,
    String? lang
  }) async{
    dio.options.headers = {
      'lang':lang
    };
    return await dio.post(url,queryParameters: queries,data: data);
  }
}