import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/provider/account/account_provider.dart';
import 'package:snap_network/res/app_icons/app_icons.dart';
import 'package:snap_network/screen/profille/components/profile_header.dart';
import 'package:snap_network/screen/profille/subScreen/privacy/privacy_screen.dart';
import 'package:snap_network/screen/profille/subScreen/security/security_screen.dart';
import 'package:snap_network/screen/profille/subScreen/terms/terms_screen.dart';

import '../../helper/custom_tiles.dart';
import '../helpSupport/help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountProvider>(context,listen: false);
    provider.fetchUserProfile();
    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
            children: [
              ProfileHeader(),
              SizedBox(height: 20.0,),
              CustomTiles(image: AppIcons.ic_privacy,press: (){
              //  Get.to(ReferralScreen());
               Get.to(PrivacyScreen());
              }, text: "Privacy & Policies",),
              Divider(color: Colors.grey,),

              SizedBox(height: 20.0,),
              CustomTiles(image: AppIcons.ic_security,press: (){
                Get.to(SecurityScreen());
              }, text: "Security",),
              Divider(color: Colors.grey,),

              SizedBox(height: 20.0,),
              CustomTiles(image: AppIcons.ic_help,press: (){
                Get.to(HelpSupportScreen());
              }, text: "Helps & Support",),
              Divider(color: Colors.grey,),

              SizedBox(height: 20.0,),
              CustomTiles(image: AppIcons.ic_terms,press: (){
                Get.to(TermsScreen());
              }, text: "Terms & Condition",),
              Divider(color: Colors.grey,),

              SizedBox(height: 20.0,),
              CustomTiles(image: AppIcons.ic_logout,press: (){
               customDialog(onClick: (){
                 logout();
               }, title: "Logout", content: "are you sure to logout?");
              }, text: "Logout",),
              Divider(color: Colors.grey,),

            ],
            ),
          ),
        ),
      ),
    );
  }
}
