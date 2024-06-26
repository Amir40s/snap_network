import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/model/user/user_model.dart';
import 'package:snap_network/provider/account/account_provider.dart';
import 'package:snap_network/provider/mining/mining_provider.dart';
import 'package:snap_network/provider/tabButton/tab_button_provider.dart';
import 'package:snap_network/provider/user/user_provider.dart';

import '../../db_key.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MiningProvider>(context,listen: false);
    final accountProvider = Provider.of<AccountProvider>(context,listen: false);
    provider.checkMiningCompletion(context: context);
    accountProvider.fetchUserProfile();
    provider.checkMiningCompletion(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200.0),
                    bottomRight: Radius.circular(200.0),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: TextWidget(text: "SNC Mining", size: 22.0,color: Colors.black, isBold: true)),
                    SizedBox(height: 10.0,),



                    Consumer<AccountProvider>(
                      builder: (context, provider, child){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                ),
                                child: TextWidget(text: "💰 ${provider.balance.toString()}", size: 22.0, isBold: true,color: Colors.white,)
                            ),

                            Container(
                                padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                ),
                                child: TextWidget(text: "Level: ${provider.userLevel}", size: 12.0, isBold: true,)
                            ),

                          ],
                        );
                      },
                    ),

                    SizedBox(height: Get.width * 0.090,),
          Consumer<MiningProvider>(
            builder: (context, provider, child){
              return GestureDetector(
                onTap: (){
                  provider.startMining(context: context);
                  firestore.collection("users").doc(auth.currentUser?.uid..toString()).update({
                    DbKey.k_mining : "start"
                  });

                },
                child: Column(
                  children: [
                    Container(
                      width: Get.width * 0.6, // Width of the circle
                      height: Get.width * 0.6, // Height of the circle
                      decoration: BoxDecoration(
                        color: Colors.black87, // Inner circle color
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white, // Border color
                          width: Get.width * 0.060, // Border width
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45, // Shadow color
                            blurRadius: 10, // Shadow blur
                            offset: Offset(0, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (provider.miningStartTime != null)
                            StreamBuilder<Duration>(
                              stream: provider.countdownStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final remainingTime = snapshot.data!;
                                  final hours = remainingTime.inHours;
                                  final minutes = remainingTime.inMinutes.remainder(60);
                                  final seconds = remainingTime.inSeconds.remainder(60);
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Remaining Time: $hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                        style: TextStyle(fontSize: 12,color: Colors.white),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ElevatedButton(
                            onPressed: () {
                              if (provider.miningStartTime == null) {
                                provider.startMining(context: context);
                              }
                            },
                            child: Text(provider.miningStartTime == null ? 'Start Mining' : 'Mining in Progress'),
                          ),
                        ],
                      ),
                      // child: Center(
                      //   // child: TextWidget(text: provider.isMining ? "Stop \n${provider.hashesComputed}" : "Start",size: 24.0,isBold: true,color: Colors.white,
                      //   child: TextWidget(
                      //     textAlignment: TextAlign.center,
                      //     text: provider.miningStartTime !=null && provider.miningStartTime!.toLocal().toString() != "1970-01-01T00:00:00.000"
                      //         ? 'Remaining Time: ${provider.remainingTime.inHours}:${provider.remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${provider.remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}'
                      //         : 'Mining not started',size: 18.0,isBold: true,color: Colors.white,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              );
            },
          ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: TextWidget(text: "My Referrals", size: 22.0,color: Colors.black, isBold: true,)),
                    SizedBox(height: 5.0,),

                    Consumer<TabButtonProvider>(
                      builder: (context, provider, child){
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      provider.activeColorVoid();
                                    },
                                    child: Column(
                                      children: [
                                        TextWidget(text: "Active", size: 14.0,isBold: true,color: provider.activeColor,),
                                        Divider(thickness: 1.5,color: provider.activeColor,)
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      provider.nonActiveColorVoid();
                                    },
                                    child: Column(
                                      children: [
                                        TextWidget(text: "Non Active", size: 14.0,isBold: true,color: provider.nonActiveColor,),
                                        Divider(thickness: 1.5,color: provider.nonActiveColor,)
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.0,),

                    Consumer<TabButtonProvider>(
                      builder: (context, provider, child){
                        return  Row(
                          children: [

                            if(provider.activeColor == primaryColor)
                              Expanded(
                                child: Consumer<UserProvider>(
                                  builder: (context, productProvider, child) {
                                    return StreamBuilder<List<UserModel>>(
                                      stream: productProvider.getProducts(context: context,status: "start"),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator(color: primaryColor,));
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text('Error: ${snapshot.error}'));
                                        }
                                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                          return Center(child: TextWidget(text: "No Referral found",size: 12.0,color: Colors.black,));
                                        }

                                        List<UserModel> users = snapshot.data!;
                                        return ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: users.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            UserModel model = users[index];

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
                                                          TextWidget(text: model.name,size: 12.0,color: Colors.black,isBold: true,),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.email),
                                                          TextWidget(text: maskEmail(model.email),size: 12.0,color: Colors.black,isBold: true,),
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
                                                    child: Center(child: TextWidget(text: "active",size: 12.0,isBold: true,)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                            if(provider.nonActiveColor == primaryColor)
                              Expanded(
                                child: Consumer<UserProvider>(
                                  builder: (context, productProvider, child) {
                                    return StreamBuilder<List<UserModel>>(
                                      stream: productProvider.getProducts(context: context,status: "end"),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator(color: primaryColor,));
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text('Error: ${snapshot.error}'));
                                        }
                                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                          return Center(child: TextWidget(text: "No Referral found",size: 12.0,color: Colors.black,));
                                        }

                                        List<UserModel> users = snapshot.data!;
                                        return ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: users.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            UserModel model = users[index];

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
                                                          TextWidget(text: model.name,size: 12.0,color: Colors.black,isBold: true,),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.email),
                                                          TextWidget(text: maskEmail(model.email),size: 12.0,color: Colors.black,isBold: true,),
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
                                                        color: Colors.orange
                                                    ),
                                                    child: Center(child: TextWidget(text: "Non Active",size: 12.0,isBold: true,)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            // Expanded(
                            //   child: Consumer<UserProvider>(
                            //     builder: (context, productProvider, child) {
                            //       return StreamBuilder<List<UserModel>>(
                            //         stream: productProvider.getProducts(context: context,status: "end"),
                            //         builder: (context, snapshot) {
                            //           if (snapshot.connectionState == ConnectionState.waiting) {
                            //             return Center(child: CircularProgressIndicator(color: primaryColor,));
                            //           }
                            //           if (snapshot.hasError) {
                            //             return Center(child: Text('Error: ${snapshot.error}'));
                            //           }
                            //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            //             return Center(child: TextWidget(text: "No Referral found",size: 12.0,color: Colors.black,));
                            //           }
                            //
                            //           List<UserModel> users = snapshot.data!;
                            //           return ListView.builder(
                            //             itemCount: users.length,
                            //             shrinkWrap: true,
                            //             itemBuilder: (context, index) {
                            //               UserModel model = users[index];
                            //
                            //               return Container(
                            //                 padding: EdgeInsets.all(10.0),
                            //                 margin: EdgeInsets.only(bottom: 10.0),
                            //                 decoration: BoxDecoration(
                            //                   color: Colors.black87,
                            //                   borderRadius: BorderRadius.circular(10.0),
                            //                 ),
                            //                 child: Column(
                            //                   mainAxisAlignment: MainAxisAlignment.start,
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //                     TextWidget(text: model.name,size: 12.0,color: Colors.white,),
                            //                     Container(
                            //                       width: Get.width * 0.20,
                            //                       height: 20.0,
                            //                       decoration: BoxDecoration(
                            //                           borderRadius: BorderRadius.circular(5.0),
                            //                           color: Colors.green
                            //                       ),
                            //                       child: Center(child: TextWidget(text: "active",size: 12.0,isBold: true,)),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               );
                            //             },
                            //           );
                            //         },
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),





            ],
          ),
        ),
        ),
      );
  }
}

// class CircularStartButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }