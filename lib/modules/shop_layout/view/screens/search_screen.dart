import 'package:flutter/material.dart';
import 'package:shop_app/Components_Consts/custom_text_form_field.dart';
import 'package:shop_app/modules/shop_layout/controller/shop_layout_cubit.dart';
import 'package:sizer/sizer.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType)=>
          Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              padding: EdgeInsets.only(left: 1.w),
              onPressed: () {
              Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back_ios,color: Colors.blue), ),
          ),
          body: Padding(
            padding: EdgeInsets.all(2.w),
            child: Card(
               shadowColor: Colors.blue.shade400,
                elevation: 3,
                child: CustomTextFormField(
                    controller: ShopLayoutCubit.get(context).searchController,
                    hintText: 'Search about anything ...',

                )),
          ),),
    );
  }
}
