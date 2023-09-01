import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Components_Consts/consts.dart';
import 'package:shop_app/modules/shop_layout/shop_layout.dart';
import 'package:shop_app/network/local/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Components_Consts/custom_button.dart';
import '../../../Components_Consts/custom_text_form_field.dart';
import '../../../Components_Consts/navigate_and_finish.dart';
import '../controller/register_cubit.dart';
import '../controller/Register_cubit_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is RegisterSuccessState){
            if(state.loginModel.status == true){
              SharedPref.setData(key: 'token', value: state.loginModel.data!.token);
              navigateTo(context, const ShopLayout());
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
          var shopCubit = ShopRegisterCubit.get(context);
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
                    key: ShopRegisterCubit.get(context).formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Register Account',
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
                                'Welcome to Our Online Shop',
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
                              ///userName
                              CustomTextFormField(
                                labelText: 'User name',
                                prefixIcon: Icons.person_2_outlined,
                                validate: (v) {
                                  if (v.isEmpty) {
                                    return 'Enter valid user name';
                                  }
                                  return null;
                                },
                                controller: shopCubit.userNameController,
                                hintText: 'Enter your name',
                              ),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                              ///email
                              CustomTextFormField(
                                labelText: 'Email',
                                prefixIcon: Icons.alternate_email_outlined,
                                validate: (v) {
                                  if (v.isEmpty) {
                                    return 'Enter valid email';
                                  }
                                  return null;
                                },
                                controller: shopCubit.emailController,
                                hintText: 'Enter your email',
                              ),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                              ///phone
                              CustomTextFormField(
                                labelText: 'Phone',
                                controller: shopCubit.phoneController,
                                prefixIcon: Icons.phone_android,
                                hintText: 'Phone',
                                validate: (v) {
                                  if (v.isEmpty) {
                                    return 'Enter valid password';
                                  }
                                  return null;
                                },

                              ),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                              ///password
                              CustomTextFormField(
                                labelText: 'Password',
                                controller: shopCubit.passwordController,
                                prefixIcon: Icons.lock_outline_sharp,
                                hintText: 'Password',
                                onSubmit: (value){
                                  if((shopCubit.formKey.currentState!.validate())){
                                    shopCubit.userRegister(
                                        email: shopCubit.emailController.text,
                                        password: shopCubit.passwordController.text,
                                        lang: 'en',
                                        userName: shopCubit.userNameController.text,
                                        phoneNumber: shopCubit.phoneController.text
                                    );}else{
                                    debugPrint('false');
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
                                  ShopRegisterCubit.get(context)
                                      .changeVisibility();
                                },
                              ),
                              SizedBox(
                                height: height(context) * 0.07,
                              ),
                              Center(
                                child: ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context) => CustomButton(
                                    onTap: (){
                                      if((shopCubit.formKey.currentState!.validate())){
                                        shopCubit.userRegister(
                                            userName: shopCubit.userNameController.text,
                                            email: shopCubit.emailController.text,
                                            phoneNumber: shopCubit.phoneController.text,
                                            password: shopCubit.passwordController.text,
                                        lang: 'en'
                                        );}else{
                                        debugPrint('false');
                                      }
                                    },
                                    borderRadius: 10,
                                    buttonText: 'Register',
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
                                    'a member?',
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
                                        'Sign In now',
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
