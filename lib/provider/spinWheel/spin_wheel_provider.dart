// import 'package:flutter/material.dart';
// import 'dart:math';
//
// class SpinWheelProvider with ChangeNotifier {
//   double _spinValue = 0.0;
//
//   double get spinValue => _spinValue;
//
//   void setSpinValue(double value) {
//     _spinValue = value;
//     notifyListeners();
//   }
//
//   String getPrize() {
//     int segment = ((360 - (_spinValue * (180 / pi)) % 360) / 45).floor();
//     switch (segment) {
//       case 0:
//         return '0.00100 coin';
//       case 1:
//         return '0.00200 coin';
//       case 2:
//         return '0.00300 coin';
//       case 3:
//         return '0.00400 coin';
//       case 4:
//         return '0.00500 coin';
//       case 5:
//         return '0.00350 coin';
//       case 6:
//         return '0.00300 coin';
//       case 7:
//         return '0.00500 coin';
//       default:
//         return '0.00100 coin';
//     }
//   }
// }

import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';


class SpinWheelProvider extends ChangeNotifier {
  double _spinValue = 0;

  double get spinValue => _spinValue;

  void setSpinValue(double newValue) {
    _spinValue = newValue;
    notifyListeners();
  }

  String getPrize() {
    const prizes = [
      '0.00100',
      '0.00200',
      '0.00300',
      '0.00400',
      '0.00500',
      '0.00350',
      '0.00300',
      '0.00500'
    ];

    int segment = ((_spinValue % (2 * pi)) / (pi / 4)).floor();
    return prizes[segment % prizes.length];
  }
}



