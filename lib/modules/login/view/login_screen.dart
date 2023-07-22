import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Components_Consts/consts.dart';
import 'package:shop_app/modules/login/controller/Login_cubit.dart';
import 'package:shop_app/modules/login/controller/Login_cubit_states.dart';
import 'package:shop_app/modules/shop_layout/shop_layout.dart';
import 'package:shop_app/network/local/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../Components_Consts/custom_button.dart';
import '../../../Components_Consts/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, state) {
          if(state is LoginSuccessState){
            if(state.loginModel.status == true){
              SharedPref.setData(key: 'token', value: state.loginModel.data!.token);
              ShopLoginCubit.get(context).navigateTo(context, const ShopLayout());
              Fluttertoast.showToast(
                  msg: state.loginModel.message as String,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.lightGreen,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }else{
              Fluttertoast.showToast(
                  msg: state.loginModel.message as String,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (BuildContext context, state) {
          var shopCubit = ShopLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blue,
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                    key: ShopLoginCubit.get(context).formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Login Account',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height(context) * 0.01,
                              ),
                              Text(
                                'Hello,Welcome Back',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height(context) * 0.08,
                              ),
                              ///email
                              CustomTextFormField(
                                labelText: 'Password',
                                validate: (v) {
                                  if (v.isEmpty) {
                                    return 'Enter valid email';
                                  }
                                  return null;
                                },
                                controller: shopCubit.emailController,
                                hintText: 'Enter Username',
                              ),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                              ///password
                              CustomTextFormField(
                                labelText: 'Password',
                                controller: shopCubit.passwordController,
                                hintText: 'Password',
                                onSubmit: (value){
                                  if((shopCubit.formKey.currentState!.validate())){
                                    shopCubit.userLogin(
                                        email: shopCubit.emailController.text,
                                        password: shopCubit.passwordController.text,
                                        lang: 'en'
                                    );}else{
                                    print('false');
                                  }
                                },
                                validate: (v) {
                                  if (v.isEmpty) {
                                    return 'Enter valid password';
                                  }
                                  return null;
                                },
                                isPasswordField: true,
                                isPasswordShown: shopCubit.isPassword,
                                passwordFun: () {
                                  ShopLoginCubit.get(context)
                                      .changeVisibility();
                                },
                              ),
                              SizedBox(
                                height: height(context) * 0.015,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'Reset Password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: height(context) * 0.07,
                              ),
                              Center(
                                child: ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => CustomButton(
                                    onTap: (){
                                      if((shopCubit.formKey.currentState!.validate())){
                                        shopCubit.userLogin(
                                            email: shopCubit.emailController.text,
                                            password: shopCubit.passwordController.text,
                                        lang: 'en'
                                        );}else{
                                        print('false');
                                      }
                                    },
                                    borderRadius: 10,
                                    buttonText: 'Sign In',
                                    buttonColor: Colors.white,
                                    buttonTextColor: Colors.blue,
                                  ),
                                  fallback: (context) { return const CircularProgressIndicator(color: Colors.white,);  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Not a member?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Register now',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
