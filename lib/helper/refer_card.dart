import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/provider/account/account_provider.dart';

import '../constant.dart';
class ReferCard extends StatelessWidget {
  const ReferCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<AccountProvider>(
     builder: (context,provider,child){
       provider.getReferral(provider.username);
       provider.getReferralQualified(provider.username);
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
             TextWidget(text: "Referral", size: 18.0, isBold: true,),
             SizedBox(height: 10.0,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 TextWidget(text: "Total no of Referral", size: 14.0),
                 TextWidget(text: provider.referralLength.toString(), size: 14.0,isBold: true,)
               ],
             ),
             SizedBox(height: 10.0,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 TextWidget(text: "Total no of qualified Referral", size: 14.0),
                 TextWidget(text: provider.referralLengthQualified.toString(), size: 14.0,isBold: true,color: Colors.black,)
               ],
             ),
           ],
         ),
       );
     },
    );
  }
}
