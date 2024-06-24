import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snap_network/helper/button_widget.dart';
import 'package:snap_network/provider/account/account_provider.dart';
import 'package:snap_network/res/app_assets/app_assets.dart';
import 'package:snap_network/res/app_string/app_string.dart';
import 'package:snap_network/service/dyanmicLink/dynamic_link_service.dart';

import '../../constant.dart';
import '../../helper/refer_card.dart';
import '../../helper/text_widget.dart';
class ReferFriendScreen extends StatelessWidget {
   ReferFriendScreen({super.key});

  late StreamSubscription<PendingDynamicLinkData> _linkSubscription;

  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<AccountProvider>(context,listen: false);
   createDynamicLink(provider.username.toString(),context);
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: TextWidget(text: "Refer & Earn",size: 18.0,color: Colors.black,),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ReferCard(),
                SizedBox(height: 10.0,),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: AlignmentDirectional.center,
                          child: Image.asset(AppAssets.bag_image,width: 100.0,height: 100.0,)),
                      SizedBox(height: 10.0,),
                      TextWidget(text: "Refer and Earn Free Crytocurrency",size: 14.0,isBold: true,),
                      SizedBox(height: 10.0,),
                      TextWidget(text: AppString.refText,size: 12.0,),
                      SizedBox(height: 10.0,),
                      TextWidget(text: "Your Refferal Link",size: 14.0,isBold: true,),
                      SizedBox(height: 10.0,),
                      Container(
                        padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 0.5,color: Colors.black)
                      ),
                        child: Consumer<AccountProvider>(
                         builder: (context, provider, child){
                           return Stack(
                             children: [
                               Container(
                                   alignment: AlignmentDirectional.centerStart,
                                   child: TextWidget(text: provider.refferralLink, size: 12.0)),
                               Align(
                                   alignment: AlignmentDirectional.centerEnd,
                                   child: ButtonWidget(text: "Copy Code",
                                     textColor: Colors.black,
                                     onClicked: (){
                                     debugPrint("click");
                                     Clipboard.setData(ClipboardData(text: provider.refferralLink));
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       const SnackBar(
                                         content: Text('Link copied to clipboard!'),
                                       ),
                                     );
                                    // createDynamicLink(provider.username.toString(),context);
                                   }, width: 100.0, height: 40.0,radius: 10.0,))
                             ],
                           );
                         },
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      ButtonWidget(
                        text: "Share Now",
                        textColor: Colors.black,
                        onClicked: (){
                        debugPrint("click");
                        Share.share("Join Snap Network For Advanced Mining Referral Link: ${provider.refferralLink}");
                      }, width: Get.width, height: 50.0),
                      SizedBox(height: 20.0,),
                      Align(
                          alignment: AlignmentDirectional.center,
                          child: TextWidget(
                            text: "Terms and Condition applied",
                            size: 12.0,color: Colors.black,
                            textAlignment: TextAlign.center,
                          ))

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createDynamicLink(String username,BuildContext context) async{
    debugPrint("Run");
    DynamicLinkService.instance.createDynamicLink(username,context);
  }

  void initDynamicLinks() async {
    _linkSubscription = FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? dynamicLink) {
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) {
        handleDeepLink(deepLink);
      }
    }, onError: (error) {
      debugPrint('Error: $error');
    });

    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = initialLink?.link;
    if (deepLink != null) {
      handleDeepLink(deepLink);
    }
  }

  void handleDeepLink(Uri deepLink) {
    if (deepLink.queryParameters.containsKey('username')) {
      String username = deepLink.queryParameters['username']!;
      debugPrint('Username: $username');
      // Handle the username, e.g., navigate to a specific page or perform an action
    }
  }

}
