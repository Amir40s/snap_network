import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/provider/account/account_provider.dart';

class DynamicLinkService{
  static final DynamicLinkService _singleton = DynamicLinkService._internal();
  DynamicLinkService._internal();

  static DynamicLinkService get instance => _singleton;


  void createDynamicLink(String username,BuildContext context) async{
    print("create");
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.google.com/referral?username=$username"),
      uriPrefix: "https://snapnetwork.page.link",
      androidParameters: const AndroidParameters(packageName: "com.solinovation.snap_network"),
      iosParameters: const IOSParameters(
        bundleId: "com.solinovation.snapNetwork",
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    Provider.of<AccountProvider>(context,listen: false).setRefferalLInk(dynamicLink.shortUrl.toString());
    debugPrint("${dynamicLink.shortUrl}");
  }

}