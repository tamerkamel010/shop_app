import 'package:flutter/material.dart';
import 'package:shop_app/Components_Consts/components.dart';
import 'package:shop_app/Components_Consts/consts.dart';
import 'package:shop_app/network/local/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../login/view/login_screen.dart';

class OnBoardScreen extends StatelessWidget {
  List<Widget> onBoardList =[
    onBoardItem(image: "lib/assets/images/save_money.png",text: 'Hurry to use offers'),
    onBoardItem(image: "lib/assets/images/delivery.png",text: 'Delivery to anywhere'),
    onBoardItem(image: "lib/assets/images/order_now.png",text: 'Order Now'),
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
            navigateAndDelete(context,const LoginScreen());
          }, child: const Text('Skip')),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ///item of page view
          PageView.builder(
            controller:pageVCont ,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=> onBoardList[index],
            itemCount: onBoardList.length,
          ),
          ///Row of indicator and route button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Row(
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
                        navigateAndDelete(context,const LoginScreen());
                    }else{
                      pageVCont.nextPage(duration: const Duration(microseconds: 1000),curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },child: const Icon(Icons.chevron_right_outlined,color: Colors.white,size: 35,),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
