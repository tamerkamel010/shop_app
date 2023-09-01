import 'package:shared_preferences/shared_preferences.dart';
class SharedPref{
  static SharedPreferences? shared;
  static init()async{
    shared = await SharedPreferences.getInstance();
  }
  ///general method
  static Future<bool> setData({required String key,required value})async{

    if(value is bool)return await shared!.setBool(key, value);
    if(value is int)return await shared!.setInt(key, value);
    if(value is double) return await shared!.setDouble(key, value);
    return await shared!.setString(key, value);

  }
  static Object? get({required String key}){
    return shared!.get(key);
  }
   static signOut(String token){
    shared!.remove(token);
  }
}

