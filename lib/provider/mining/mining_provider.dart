import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
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
  Timer? _countdownTimer;
  Duration _elapsedTime = Duration.zero;
  StreamController<Duration> _countdownController = StreamController<Duration>.broadcast();
  Duration _remainingTime = Duration(hours: 3);

  Duration get remainingTime => _remainingTime;
  Duration get elapsedTime => _elapsedTime;

  MiningProvider({required this.userId}) {
    _loadMiningData();
  }

  DateTime? get miningStartTime => _miningStartTime;
  double get walletBalance => _walletBalance;
  Stream<Duration> get countdownStream => _countdownController.stream;

  _loadMiningData() async {
    final data = await _firestoreService.getUserData(userId);
    if (data['miningStartTime'] != null) {
      _miningStartTime = DateTime.parse(data['miningStartTime']);
      _startCountdownTimer();
     // _calculateRemainingTime();
    }
    _walletBalance = data['walletBalance']?.toDouble() ?? 0.0;
    notifyListeners();
  }

  startMining({required BuildContext context}) async {
    _miningStartTime = DateTime.now().toUtc();
    await _firestoreService.startMining(userId, _miningStartTime!);
    _startCountdownTimer();
    notifyListeners();
  }

  _startCountdownTimer() {
    // _countdownTimer?.cancel();
    // _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   _calculateTimes();
    //   if (_remainingTime.isNegative) {
    //     timer.cancel();
    //    checkMiningCompletion(context: context);
    //   }
    //   notifyListeners();
    // });
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _calculateTimes();
    });
  }




  _calculateTimes() {
    if (_miningStartTime != null) {
      final currentTime = DateTime.now().toUtc();
      final duration = currentTime.difference(_miningStartTime!);
      final remainingTime = Duration(hours: 3) - duration;
      _countdownController.add(remainingTime);

      if (remainingTime.isNegative) {
        _countdownTimer?.cancel();
        _miningStartTime = null;
        notifyListeners();
        // checkMiningCompletion();
      }
    }
  }

  _calculateRemainingTime() {
    if (_miningStartTime != null) {
      final currentTime = DateTime.now().toUtc();
      final duration = currentTime.difference(_miningStartTime!);
      _remainingTime = Duration(hours: 3) - duration;
    }
  }


  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownController.close();
    super.dispose();
  }

  checkMiningCompletion({required BuildContext context}) async {
    if (_miningStartTime == null) return;

    final provider = Provider.of<AccountProvider>(context,listen: false);

    final currentTime = DateTime.now();
    final duration = currentTime.difference(_miningStartTime!);

    log("Mining Completion Run");
    if (duration.inHours >= 3) {
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
