import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/screen/signup/signup_screen.dart';

import '../../helper/button_widget.dart';
import '../../helper/custom_richtext.dart';
import '../../helper/text_widget.dart';
import '../../res/app_assets/app_assets.dart';
import '../login/login_screen.dart';
class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black,
          padding: const  EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logo,height: Get.width / 2,),
              SizedBox(height: Get.width / 9,),
              CustomRichText(press: (){}, firstText: "Welcome",firstColor: Colors.white, secondText: "To Snap Network Mining",firstSize: 20.0,secondSize: 20.0,),
              SizedBox(height: 20.0,),
              CustomRichText(press: (){}, firstText: "Crypto", firstColor: Colors.white,secondText: "SNC",firstSize: 20.0,secondSize: 20.0,),
              SizedBox(height: Get.width / 2.5,),


              ButtonWidget(text: "Login",onClicked: (){
                Get.to(LoginScreen());
              },width: Get.width,height: 50.0,),
              SizedBox(height: 10.0,),
              Align(
                  alignment: AlignmentDirectional.center,
                  child: TextWidget(text: "or",size: 12.0,)),
              SizedBox(height: 10.0,),
              ButtonWidget(text: "Sign Up",onClicked:(){
                Get.to(SignupScreen());
              },width: Get.width,height: 50.0,backgroundColor: lightBlue,),

            ],
          ),
        ),
      ),
    );
  }
}
