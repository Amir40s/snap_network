import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';

import '../../provider/bottomBar/bottom_bar_provider.dart';
class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});

  final double defaultIconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    var bottomBarProvider = Provider.of<BottomBarProvider>(context, listen: false);
    return Consumer<BottomBarProvider>(
      builder: (context,provider, child){
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: provider.myList[provider.myIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: (value){
              log("Value: $value");
              bottomBarProvider.changeMyIndex(value);
            },
            currentIndex: bottomBarProvider.myIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),

              // BottomNavigationBarItem(
              //   icon: Icon(Icons.pie_chart),
              //   label: "Portfolio",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: "Reward",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: "Leaderboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
