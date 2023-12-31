import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/controller/Login_cubit_states.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
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
  ShopLayoutCubit cubit = ShopLayoutCubit();
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
    debugPrint(isPassword.toString());
    emit(ChangeVisibilityState());
}
   userLogin({required String email,required String password,String? lang = 'ar'}){
    emit(LoginLoadingState());
    DioHelper.postData(url: login, data: {"email":email,
      "password":password,
    },lang: lang).then((v){

      loginModel = LoginModel.fromJson(v.data);
      debugPrint(loginModel!.message);
      emit(LoginSuccessState(loginModel: loginModel!));
      cubit.getProfile();
    }).catchError((error){
      debugPrint(error);
      emit(LoginErrorState(error: error.toString()));
    });
  }

}