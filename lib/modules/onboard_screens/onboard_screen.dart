import 'package:flutter/material.dart';
import 'package:shop_app/Components_Consts/components.dart';
import 'package:shop_app/Components_Consts/consts.dart';
import 'package:shop_app/network/local/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../login/view/login_screen.dart';

class OnBoardScreen extends StatelessWidget {
  List<Widget> onBoardList =[
    OnBoardItem(iconData: Icons.add_shopping_cart_outlined,text: 'Add item'),
    OnBoardItem(iconData: Icons.delivery_dining_sharp,text: 'Delivery anywhere'),
    OnBoardItem(iconData: Icons.shopping_cart_rounded,text: 'Shop Now'),
  ];
  PageController pageVCont = PageController();
  bool isLast = false;

  OnBoardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: ()
          {
            SharedPref.setData(key: 'finishOnboard', value: true);
            NavigateAndDelete(context,const LoginScreen());
          }, child: const Text('Skip')),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ///item of page view
              Expanded(child: PageView.builder(
                controller:pageVCont ,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=> onBoardList[index],
                itemCount: onBoardList.length,
              )),
              ///Row of indicator and route button
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageVCont,
                    count: onBoardList.length,
                    effect:  ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: primaryColor,
                      expansionFactor: 3,
                      dotHeight: 10,
                      spacing: 3
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: primaryColor,
                    onPressed:(){
                      if(pageVCont.page == onBoardList.length -1){
                          isLast = true;
                          SharedPref.setData(key: 'finishOnboard', value: true);
                          NavigateAndDelete(context,const LoginScreen());
                      }else{
                        pageVCont.nextPage(duration: const Duration(microseconds: 1000),curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },child: const Icon(Icons.chevron_right_outlined,color: Colors.white,size: 35,),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
