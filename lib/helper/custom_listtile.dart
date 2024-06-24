import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_network/helper/text_widget.dart';

import '../constant.dart';
class CustomListTile extends StatelessWidget {
  final icon,title,subtitle;
  final VoidCallback press;
  const CustomListTile({super.key, required this.icon, required this.title, required this.subtitle, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Image.asset(icon,width: 30.0,height: 30.0,),
            SizedBox(width: Get.width * 0.050,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: title, size: 18.0),
                SizedBox(height: 2.0,),
                TextWidget(text: subtitle, size: 12.0),
              ],
            ),
            SizedBox(width: Get.width * 0.050,),
            Icon(Icons.arrow_forward_ios,size: 20.0,),
          ],
        ),
      ),
    );
  }
}
