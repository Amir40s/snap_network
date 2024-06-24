import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/helper/button_widget.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/provider/radioButton/radio_provider.dart';
import 'package:snap_network/res/app_assets/app_assets.dart';

import '../../helper/custom_radiobutton.dart';
import '../../res/app_icons/app_icons.dart';
class PaymentOptionScreen extends StatelessWidget {
  const PaymentOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RadioButtonProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
            padding: EdgeInsets.all(10.0),
            child: Image.asset(AppAssets.back_image,width: 25.0,height: 25.0,)),
        title: TextWidget(text: "Payment Option",size: 14.0,isBold: true,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0,),
                TextWidget(text: "UPI", size: 14.0,isBold: true,),

                SizedBox(height: 10.0,),
                CustomRadioButton(
                  value: "1",
                  groupValue: provider.selectedOption,
                  onChanged: (value) => provider.setSelectedOption(value),
                  text: 'GPAY',
                  image: AppIcons.ic_gpay,
                ),

                SizedBox(height: 20.0,),
                TextWidget(text: "Card", size: 14.0,isBold: true,),
                SizedBox(height: 10.0,),
                CustomRadioButton(
                  value: "2",
                  groupValue: provider.selectedOption,
                  onChanged: (value) => provider.setSelectedOption(value),
                  text: '2367 2752 *****',
                  image: AppIcons.ic_card,
                ),

                SizedBox(height: 20.0,),
                TextWidget(text: "Cash", size: 14.0,isBold: true,),
                SizedBox(height: 10.0,),
                CustomRadioButton(
                  value: "3",
                  groupValue: provider.selectedOption,
                  onChanged: (value) => provider.setSelectedOption(value),
                  text: 'Jazz Cash',
                  image: AppIcons.ic_cash,
                ),

                SizedBox(height: 100.0,),
                ButtonWidget(text: "Proceed", onClicked: (){}, width: Get.width, height: 50.0,radius: 10.0,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
