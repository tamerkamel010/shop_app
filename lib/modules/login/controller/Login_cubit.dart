import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/controller/Login_cubit_states.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/network/remote/dio.dart';
import '../../../models/shop_login_model.dart';
import '../../../network/local/shared_preferences.dart';
import '../../../network/remote/endpoints.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(InitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  bool finishOnboard = SharedPref.get(key: 'finishOnboard') as bool ?? false;
  bool isPassword = true;
  bool visible = false;
  var formKey = GlobalKey<FormState>();
  bool isError = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginModel? loginModel;
  void navigateTo(context, Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  changeVisibility(){
    isPassword = !isPassword;
    print(isPassword);
    emit(ChangeVisibilityState());
}
   userLogin({required String email,required String password,String? lang = 'ar'}){
    emit(LoginLoadingState());
    DioHelper.postData(url: login, data: {"email":email,
      "password":password,
    },lang: lang).then((v){
      loginModel = LoginModel.fromJson(v.data);
      print(loginModel!.message);
      emit(LoginSuccessState(loginModel: loginModel!));
    }).catchError((error){
      print(error);
      emit(LoginErrorState(error: error.toString()));
    });
  }

}