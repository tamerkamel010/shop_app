import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/network/remote/dio.dart';
import '../../../models/shop_login_model.dart';
import '../../../network/remote/endpoints.dart';
import 'Register_cubit_states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super(RegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  bool visible = false;
  var formKey = GlobalKey<FormState>();
  bool isError = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginModel? loginModel;

  changeVisibility(){
    isPassword = !isPassword;
    debugPrint(isPassword.toString());
    emit(RegisterChangeVisibilityState());
}
   userRegister({
     required String email,
     required String userName,
     required String phoneNumber,
     required String password,
     String? lang = 'ar',

   }){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: register,
        data: {
          "email":email,
      "password":password,
          "name":userName,
          "phone":phoneNumber
    },lang: lang).then((v){
      loginModel = LoginModel.fromJson(v.data);
      debugPrint(loginModel!.message);
      emit(RegisterSuccessState(loginModel: loginModel!));
    }).catchError((error){
      debugPrint(error);
      emit(RegisterErrorState(error: error.toString()));
    });
  }

}