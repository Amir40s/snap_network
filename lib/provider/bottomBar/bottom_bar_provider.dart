
import 'package:flutter/material.dart';
import 'package:snap_network/screen/home/home_screen.dart';
import 'package:snap_network/screen/login/login_screen.dart';
import 'package:snap_network/screen/market/market_screen.dart';
import 'package:snap_network/screen/portfolio/portfolio_screen.dart';
import 'package:snap_network/screen/profille/profile_screen.dart';
import 'package:snap_network/screen/reward/reward_screen.dart';





class BottomBarProvider with ChangeNotifier {
  int _myIndex = 0;
  List<Widget> _myList = [
    HomeScreen(),
   // PortfolioScreen(),
    RewardScreen(),
    MarketScreen(),
    ProfileScreen(),
  ];

  int get myIndex => _myIndex;

  List<Widget> get myList => _myList;

  void changeMyList(List<Widget> list) {
    _myList = list;
    notifyListeners();
  }

  void changeMyIndex(int index) {
    _myIndex = index;
    notifyListeners();
  }
}