// // lib/mining_provider.dart
//
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:crypto/crypto.dart';
//
// class MiningProvider extends ChangeNotifier {
//   bool _isMining = false;
//   int _hashesComputed = 0;
//   bool _showWarning = false;
//
//   bool get isMining => _isMining;
//   int get hashesComputed => _hashesComputed;
//   bool get showWarning => _showWarning;
//
//   void startMining() async {
//     _isMining = true;
//     _hashesComputed = 0;
//     _showWarning = true;
//     notifyListeners();
//
//     await Future.delayed(Duration(milliseconds: 100)); // Ensure UI updates
//
//     final random = Random();
//     while (_isMining) {
//       final data = utf8.encode(random.nextDouble().toString());
//       sha256.convert(data); // Perform hash computation
//       _hashesComputed++;
//       notifyListeners();
//       await Future.delayed(Duration(milliseconds: 1)); // Simulate computation delay
//     }
//   }
//
//   void stopMining() {
//     _isMining = false;
//     notifyListeners();
//   }
// }

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/db_key.dart';
import 'package:snap_network/provider/account/account_provider.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> startMining(String userId, DateTime startTime) async {
    await _db.collection('mining').doc(userId).set({
      'miningStartTime': startTime.toIso8601String(),
    }, SetOptions(merge: true));
  }

  Future<void> updateWalletBalance(String userId, double walletBalance) async {
    await _db.collection('mining').doc(userId).set({
      'walletBalance': walletBalance,
    }, SetOptions(merge: true));
    await firestore.collection("users").doc(userId).update({
      "balance": walletBalance.toStringAsFixed(2),
      DbKey.k_mining : "end"
    });

  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot doc = await _db.collection('mining').doc(userId).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : {};
  }
}


class MiningProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final String userId;
  DateTime? _miningStartTime;
  double _walletBalance = 0.0;
  final double _miningIncome = 0.20;

  MiningProvider({required this.userId}) {
    _loadMiningData();
  }

  DateTime? get miningStartTime => _miningStartTime;
  double get walletBalance => _walletBalance;

  _loadMiningData() async {
    final data = await _firestoreService.getUserData(userId);
    if (data['miningStartTime'] != null) {
      _miningStartTime = DateTime.parse(data['miningStartTime']);
    }
    _walletBalance = data['walletBalance']?.toDouble() ?? 0.0;
    notifyListeners();
  }

  startMining() async {
    _miningStartTime = DateTime.now();
    await _firestoreService.startMining(userId, _miningStartTime!);
    notifyListeners();
  }

  checkMiningCompletion({required BuildContext context}) async {
    if (_miningStartTime == null) return;

    final provider = Provider.of<AccountProvider>(context,listen: false);

    final currentTime = DateTime.now();
    final duration = currentTime.difference(_miningStartTime!);

    log("Mining Completion Run");
    if (duration.inMinutes >= 1) {
      log("Mining time completed");
      log("User Level: ${provider.userLevel}");

      if(provider.userLevel == "1"){
        _walletBalance += _miningIncome + 0.5;
      }else if(provider.userLevel == "2"){
        _walletBalance += _miningIncome + 0.10;
      }else if(provider.userLevel == "3"){
        _walletBalance += _miningIncome + 0.15;
      }else{
        _walletBalance += _miningIncome + 0.0;
      }
      log("Wallet balance: $_walletBalance");
      log("Mining balance: $_miningIncome");
      await _firestoreService.updateWalletBalance(userId, _walletBalance);
      _miningStartTime = null;
      await _firestoreService.startMining(userId, DateTime(1970, 1, 1)); // Reset start time to null
      notifyListeners();
    }
  }
}
