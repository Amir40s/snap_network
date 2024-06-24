import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/screen/plans/components/price_details_rows.dart';

import 'button_widget.dart';
class PriceCard extends StatelessWidget {
  bool isCredit;
  final String price,planName;
  final VoidCallback press;
   PriceCard({super.key,this.isCredit  = false, required this.price, required this.planName, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
      width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(width: 1.0,color: Colors.black)
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey,
              ),
              child: TextWidget(text: planName,size: 13.0,isBold: true,),
            ),

            SizedBox(height: 10.0,),
            TextWidget(text: "For all individuals and starters who want to start with domaining", size: 12.0),
            SizedBox(height: 10.0,),
            Divider(color: Colors.grey,),
            SizedBox(height: 20.0,),

            TextWidget(text: "\$$price", size: 35.0, isBold: true,),
            SizedBox(height: 10.0,),
            TextWidget(text: "per member, per month", size: 14.0, isBold: true,),
            SizedBox(height: 20.0,),
            Divider(color: Colors.grey,),
            SizedBox(height: 20.0,),

            PriceDetailsRows(text: "Access to All Features"),
            PriceDetailsRows(text: "1k lookups / per month"),
            PriceDetailsRows(text: "1k lookups / per month"),
            PriceDetailsRows(text: "No API Credits",isCredit: isCredit),
            PriceDetailsRows(text: "10 Monitoring Quota"),
            PriceDetailsRows(text: "60 minutes Monitoring intervel"),
            PriceDetailsRows(text: "20% discount on backorders"),
            PriceDetailsRows(text: "Domain Name Appraisal (Coming Soon)"),
            PriceDetailsRows(text: "Ip Monitoring (Coming Soon)"),
            PriceDetailsRows(text: "Backlink Monitoring (Coming Soon)"),
            SizedBox(height: 20.0,),

            ButtonWidget(text: "Start free 14-days Trial", onClicked: (){},
              width: Get.width,
              height: 40.0,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              radius: 10.0,
            ),
            SizedBox(height: 10.0,),
            Align(
                alignment: AlignmentDirectional.center,
                child: TextWidget(text: "No Credit Card Required", size: 12.0)),

          ],
        ),
      ),
    );
  }
}
