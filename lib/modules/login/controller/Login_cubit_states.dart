import '../../../models/shop_login_model.dart';

abstract class ShopLoginStates{}
class InitialState extends ShopLoginStates{}
class LoginSuccessState extends ShopLoginStates{
  final LoginModel loginModel;
  LoginSuccessState({required this.loginModel});
}
class LoginLoadingState extends ShopLoginStates{}
class LoginErrorState extends ShopLoginStates{
  final String error;
  LoginErrorState({required this.error});
}
class ChangeVisibilityState extends ShopLoginStates{}



