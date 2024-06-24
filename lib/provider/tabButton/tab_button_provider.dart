import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';

import '../../helper/text_widget.dart';
import '../../model/user/user_model.dart';
import '../user/user_provider.dart';

class TabButtonProvider extends ChangeNotifier{

  Color _activeColor = primaryColor;
  Color _nonActiveColor = Colors.grey;


  Color get activeColor => _activeColor;
  Color get nonActiveColor => _nonActiveColor;

  void activeColorVoid(){
    _activeColor = primaryColor;
    _nonActiveColor = Colors.grey;
    notifyListeners();
  }
  void nonActiveColorVoid(){
    _activeColor = Colors.grey;
    _nonActiveColor = primaryColor;
    notifyListeners();
  }



}