import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_network/helper/text_widget.dart';
class CustomTiles extends StatelessWidget {
  final String image, text;
  final VoidCallback press;
  const CustomTiles({super.key, required this.image, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: ListTile(
        leading: Image.asset(image,width: 24.0,height: 24.0,color: Colors.black,),
        title: TextWidget(text: text,size: 14.0,),
        trailing: Icon(Icons.arrow_forward_ios,),
        onTap: press
      ),
    );
  }
}
