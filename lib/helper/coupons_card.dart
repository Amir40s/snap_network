import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/provider/account/account_provider.dart';

import '../constant.dart';
class CouponsCard extends StatelessWidget {
  const CouponsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<AccountProvider>(
      builder: (context,provider, child){
        return Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: "Coupons", size: 18.0, isBold: true,),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text: "No. of coupons won", size: 14.0),
                  TextWidget(text: "06", size: 14.0,isBold: true,)
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text: "Total Spins", size: 14.0),
                  TextWidget(text: provider.totalSpin.toString(), size: 14.0,isBold: true,color: Colors.black,)
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text: "Remaining coupons to spin", size: 14.0),
                  TextWidget(text: "08", size: 14.0,isBold: true,color: Colors.black,)
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
