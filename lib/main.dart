import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/remote/dio.dart';
import 'package:shop_app/modules/login/view/login_screen.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:sizer/sizer.dart';
import 'Components_Consts/blocObserver.dart';
import 'modules/onboard_screens/onboard_screen.dart';
import 'modules/shop_layout/shop_layout.dart';
import 'network/local/shared_preferences.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  DioHelper.dio;
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
  
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    bool? finishOnboard= SharedPref.get(key: 'finishOnboard')as bool? ?? false;
    String? token = SharedPref.get(key: 'token') as String?;
    print(token);
    Widget? startWidget;
    if(finishOnboard == true){
      if(token != null){startWidget = const ShopLayout();}else{
        startWidget = const LoginScreen();
      }
      }else{
      startWidget =OnBoardScreen();
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> ShopLayoutCubit()
          ..getHomeData()
          ..getCategoriesData()
          ..getFavoritesData()
          ..getProfile()),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
          return MaterialApp(
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          home: startWidget,
          theme: ThemeData(
              //visualDensity: VisualDensity.adaptivePlatformDensity,
              useMaterial3: true,
              primaryColor: Colors.white,
              primarySwatch: Colors.blue,
              appBarTheme:  const AppBarTheme(
                iconTheme:  IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                color: Colors.white,
                elevation: 0.0,
              ),
              iconTheme: const IconThemeData(
                  color: Colors.blue
              ),
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                      color: Colors.white
                  )
              )
          ),
        );  },
      ),
    );
  }
}
