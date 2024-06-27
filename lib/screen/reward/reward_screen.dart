import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/helper/coupons_card.dart';
import 'package:snap_network/helper/refer_card.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/screen/referFriend/refer_friend_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import '../../helper/market_card.dart';
import '../../provider/account/account_provider.dart';
import '../../res/app_assets/app_assets.dart';
import '../spinWheel/spin_wheel_screen.dart';
class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});
  final double defaultSpacing = 10.0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountProvider>(context,listen: false);
    provider.getSpin();
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Rewards",size: 14.0,isBold: true,),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      backgroundColor: lightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                CouponsCard(),
                SizedBox(height: 10.0,),
                ReferCard(),



                SizedBox(height: 20.0,),
                MarketCard(
                  title: 'Refer and Earn',
                  subtitle: 'Refer you friend and earn Cryptocoins',
                  image: AppAssets.like_image,
                  buttonText: 'Refer Now',
                  backgroundColor: orange,
                  press: () {
                    Get.to(ReferFriendScreen());
                  },
                ),
                SizedBox(height: defaultSpacing,),
                MarketCard(
                  title: 'Rewards',
                  subtitle: 'Like share & get free coupons',
                  image: AppAssets.share_image,
                  buttonText: 'Follow Us',
                  backgroundColor: purple,
                  press: () {
                      launchWebUrl(url: "https://x.com/theSnapNetwork?t=lXM3avkZdX2-S8tO3Qeavg&s=09");
                  },
                ),
                SizedBox(height: defaultSpacing,),
                MarketCard(
                  title: 'Rewards',
                  subtitle: 'Spin Wheel & Win free tokens',
                  image: AppAssets.wheel_image,
                  buttonText: 'Get Tokens',
                  backgroundColor: pink,
                  press: () {
                    Get.to(SpinWheelScreen());
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> launchWebUrl({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
