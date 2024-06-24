import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_network/screen/bottomBar/bottom_bar_screen.dart';
import 'package:snap_network/screen/confirm/confirm_screen.dart';

import '../../constant.dart';
import '../../res/app_assets/app_assets.dart';
import '../login/login_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4),(){
      //Get.offAll(const ConfirmScreen());
      if(auth.currentUser !=null ){
        Get.offAll(()=> const BottomBarScreen());
      }else{
        Get.offAll(ConfirmScreen());
      }

    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(AppAssets.logo,width: Get.width / 1.5,),
      ),
    );
  }
}
