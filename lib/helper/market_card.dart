import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/button_widget.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/res/app_assets/app_assets.dart';
class MarketCard extends StatelessWidget {
  final String title,subtitle,image,buttonText;
  final VoidCallback press;
  final Color backgroundColor;
  const MarketCard({super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.buttonText,
    required this.press,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.only(top: Get.width * 0.0300,right: 5.0,left: Get.width * 0.0300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TextWidget(text: title, size: 12.0,color: Colors.white,),
              SizedBox(height: 10.0,),
              TextWidget(text: subtitle, size: 14.0,isBold: true,color: Colors.white,),
                SizedBox(height: 20.0,),
                ButtonWidget(text: buttonText, onClicked: press,
                  width: Get.width * 0.300, height: 40.0,backgroundColor: whiteColor,radius: 5.0,
                textColor: backgroundColor,
                  textSize: 12.0,
                ),
                SizedBox(height: 20.0,)
              ],
            )),
            Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                    child: Image.asset(image,height: Get.width * 0.3,fit: BoxFit.contain,))
            ),
          ],
        ),
      ),
    );
  }
}
