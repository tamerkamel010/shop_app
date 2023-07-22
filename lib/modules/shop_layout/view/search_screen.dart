import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_states.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (BuildContext context,state){},
      builder: (BuildContext context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: const SizedBox(
            height: 100,
            child: Column(
              children: [
                SizedBox(height: 5,),
                TextField()
              ],
            ),
          ),

        );
      },
    );
  }
}
