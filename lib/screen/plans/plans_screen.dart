import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/screen/payment/payment_option_screen.dart';

import '../../constant.dart';
import '../../helper/price_card.dart';
class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Plans",size: 18.0,color: Colors.white,),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(text: "WRC Pricing", size: 14.0,isBold: true,),
                SizedBox(height: 20.0,),
                TextWidget(text: "Choose your plan", size: 12.0),
                SizedBox(height: 20.0,),
                PriceCard(isCredit: true, price: '2', planName: 'Basic', press: () {
                  Get.to(PaymentOptionScreen());
                },),

                SizedBox(height: 20.0,),
                PriceCard(price: '5', planName: 'Professional', press: () {
                  Get.to(PaymentOptionScreen());
                },),
                SizedBox(height: 20.0,),
                PriceCard(price: '10', planName: 'Advanced', press: () {
                  Get.to(PaymentOptionScreen());
                },)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
