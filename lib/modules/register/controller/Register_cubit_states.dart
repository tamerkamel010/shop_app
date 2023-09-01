import '../../../models/shop_login_model.dart';

abstract class ShopRegisterStates{}
class RegisterInitialState extends ShopRegisterStates{}
class RegisterSuccessState extends ShopRegisterStates{
  final LoginModel loginModel;
  RegisterSuccessState({required this.loginModel});
}
class RegisterLoadingState extends ShopRegisterStates{}
class RegisterErrorState extends ShopRegisterStates{
  final String error;
  RegisterErrorState({required this.error});
}
class RegisterChangeVisibilityState extends ShopRegisterStates{}



