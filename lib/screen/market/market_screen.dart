import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/model/referralUser/referral_user_model.dart';
import 'package:snap_network/res/app_assets/app_assets.dart';
import '../../provider/referral/referral_provider.dart';

class MarketScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Leaderboard",size: 18.0,isBold: true,color: Colors.black,),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
               color: primaryColor.withOpacity(0.8),
                child: TopThreeUsers()),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<ReferralProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.users.isEmpty) {
                    log("message ${userProvider.users}");
                    return const Center(child: CircularProgressIndicator());
                  }

                  return userProvider.users.isNotEmpty ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userProvider.users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ReferralUserModel user = userProvider.users[index];
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    TextWidget(text: user.name,size: 12.0,color: Colors.black,isBold: true,),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    Icon(Icons.email),
                                    TextWidget(text: maskEmail(user.email),size: 12.0,color: Colors.black,isBold: true,),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Container(
                              width: Get.width * 0.20,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.green
                              ),
                              child: Center(child: TextWidget(text: "Referrals: ${user.referralCount}",size: 12.0,isBold: true,)),
                            ),
                          ],
                        ),
                      );
                    },
                  ) : Center(child: TextWidget(text: "No Leaderboard found",size: 12.0),);
                },),
            )
          ],
        ),
      ),
      );
  }
}

class TopThreeUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ReferralProvider>(
      builder: (context, provider, child) {
        if (provider.users.take(3).isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (provider.users.take(3).length > 1)
              // Second place
                _buildUserCard(
                  context,
                  provider.users[1].name,
                  provider.users[1].name,
                  provider.users[1].balance,
                  provider.users[1].userLevel,
                  Colors.blue,
                  2,
                ),
                // UserCard(user: provider.users[1]), // Top 2 user
              if (provider.users.take(3).isNotEmpty)
                _buildUserCard(
                  context,
                  provider.users[0].name,
                  provider.users[0].name,
                  provider.users[0].balance,
                  provider.users[0].userLevel,
                  Colors.green,
                  1,
                ),
              //  UserCard(user: provider.users[0], isTopUser: true), // Top 1 user
              if (provider.users.take(3).length > 2)
                _buildUserCard(
                  context,
                  provider.users[2].name,
                  provider.users[2].name,
                  provider.users[2].balance,
                  provider.users[2].userLevel,
                  Colors.cyan,
                  3,
                ),
               // UserCard(user: provider.users[2]), // Top 3 user
            ],
          ),
        );
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final ReferralUserModel user;
  final bool isTopUser;

   UserCard({required this.user, this.isTopUser = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: isTopUser ? 100 : 80,
          height: isTopUser ? 100 : 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              user.name[0].toUpperCase(),
              style: TextStyle(
                fontSize: isTopUser ? 40 : 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          user.name,
          style: TextStyle(fontSize: isTopUser ? 20 : 16),
        ),
        Text(
          'Referrals: ${user.referralCount}',
          style: TextStyle(fontSize: isTopUser ? 16 : 12),
        ),
      ],
    );
  }
}

Widget _buildUserCard(
    BuildContext context, String profileImageUrl, String name, String points, String level, Color color, int rank) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          // CircleAvatar(
          //   radius: 30,
          //   backgroundImage: NetworkImage(profileImageUrl),
          // ),
          Container(
            width: rank ==1  ? 100 : 80,
            height: rank ==1 ? 100 : 80,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: rank ==1 ? 40 : 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          if (rank == 1)
            Positioned(
              top: 0,
              child: TextWidget(text: '👑',size: 18.0,),
            ),
        ],
      ),
      SizedBox(height: 8),
      Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
    TextWidget(text: '💰 \$$points', size: 14.0, isBold: true,),
      Container(
        width: Get.width * 0.190,
        height: 200.0,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text('Rank $level', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('$rank', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          ],
        ),
      ),
    ],
  );
}

