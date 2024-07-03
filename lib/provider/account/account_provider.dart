import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../db_key.dart';
import '../value/value_provider.dart';

class AccountProvider extends ChangeNotifier {

  String _username = "";
  String _email = "";
  String _phone = "";
  String _balance = "";
  String _name = "";
  String _referral = "";
  String _profilePic = "";
  String _referralLength = "";
  String _referralLengthQualified = "";
  String _refferalLink = "";
  String _totalSpin = "";
  String _userLevel = "";
  String _isLevel1 = "";
  String _isLevel2 = "";
  String _isLevel3 = "";

  String _spinDate = "";
  bool _isSpin = false;

  Map<String, List<DocumentSnapshot>> _referrals = {};

  Map<String, List<DocumentSnapshot>> get referrals => _referrals;

  String get email => _email;

  String get username => _username;

  String get phone => _phone;
  String get profilePic => _profilePic;

  String get name => _name;

  String get referral => _referral;
  String get balance => _balance;

  String get totalSpin => _totalSpin;

  String get referralLength => _referralLength;

  String get referralLengthQualified => _referralLengthQualified;

  String get refferralLink => _refferalLink;

  String get spinDate => _spinDate;
  String get userLevel => _userLevel;
  String get isLevel1 => _isLevel1;
  String get isLevel2 => _isLevel2;
  String get isLevel3 => _isLevel3;

  bool get isSpin => _isSpin;


  void setRefferalLInk(String link) {
    _refferalLink = link;
    notifyListeners();
  }

  void setSpinDate(bool spin) {
    _isSpin = spin;
    notifyListeners();
  }



  AccountProvider() {
    log("Run account provider Constructor");
    fetchUserProfile();
  }


  Future<void> fetchReferrals(String userId) async {
    // Fetch referrals recursively
    await _fetchUserAndReferrals(userId, null);
    notifyListeners();
  }

  Future<void> _fetchUserAndReferrals(String userId, String? referrerId) async {
    QuerySnapshot userSnapshot = await firestore
        .collection('users')
        .where('referral', isEqualTo: referrerId)
        .get();

    List<DocumentSnapshot> users = userSnapshot.docs;

    _referrals[userId] = users;

    for (var user in users) {
      await _fetchUserAndReferrals(user.id, user.id);
    }
  }




 Future<void> fetchUserProfile() async {
    final uid = auth.currentUser?.uid;
    log("Runnning Profile");
    try {
      final value = await firestore.collection(DbKey.c_users).doc(uid).get();
      if (value.exists) {
        _username = value.get(DbKey.k_username).toString();
       _email = value.get(DbKey.k_email).toString();
       _phone = value.get(DbKey.k_phone).toString();
       _profilePic = value.get("profilePic").toString();
       _name = value.get("name").toString();
       _referral = value.get(DbKey.k_referral).toString();
       _balance = value.get(DbKey.k_balance).toString();
       _userLevel = value.get(DbKey.k_userLevel).toString();
       _isLevel1 = value.get(DbKey.k_isLevel1).toString();
       _isLevel2 = value.get(DbKey.k_isLevel2).toString();
       _isLevel3 = value.get(DbKey.k_isLevel3).toString();

       updateLevel(
           userLevel: value.get(DbKey.k_userLevel).toString(),
           isLevel1: value.get(DbKey.k_isLevel1).toString(),
           isLevel2: value.get(DbKey.k_isLevel2).toString(),
           isLevel3: value.get(DbKey.k_isLevel3).toString()
       );
        notifyListeners();
      } else {
        _username = "";
        _email = "";
        _phone = "";
        _name = "";
        _referral = "";
        _balance = "";
        _userLevel = "";
        _isLevel1 = "";
        _isLevel2 = "";
        _isLevel3 = "";
      }
      notifyListeners();
    } catch (e) {
      log("Error fetching account data: $e");
      if (kDebugMode) {
        print("Error fetching account data: $e");
      }
    }
    notifyListeners();
  }

   Future<void> getReferral(String username) async {
     final uid = auth.currentUser?.uid;
     log("UID: ${uid}");
     try {
       final value = await firestore.collection(DbKey.c_users)
           .where(DbKey.k_referral, isEqualTo: username).get();
       _referralLength = value.docs.length.toString();
       notifyListeners();
     } catch (e) {
       log("Error fetching account data: $e");
       if (kDebugMode) {
         print("Error fetching account data: $e");
       }
     }
     notifyListeners();
   }

   Future<void> getReferralQualified(String username) async {
     final uid = auth.currentUser?.uid;
     log("UID: ${uid}");
     try {
       final value = await firestore.collection(DbKey.c_users)
           .where(DbKey.k_referral, isEqualTo: username)
           .where(DbKey.k_mining , isEqualTo: "start")
           .get();
       _referralLengthQualified = value.docs.length.toString();
       notifyListeners();
     } catch (e) {
       log("Error fetching account data: $e");
       if (kDebugMode) {
         print("Error fetching account data: $e");
       }
     }
     notifyListeners();
   }

   Future<void> getSpin() async {
     final uid = auth.currentUser?.uid;
     DateTime time = DateTime.now();
     log("UID: ${uid}");
     try {
       final length = await firestore.collection(DbKey.c_spins)
           .doc(uid).collection("spins").get();
       _totalSpin = length.docs.length.toString();
       notifyListeners();
       
       final value = await firestore.collection(DbKey.c_spins)
           .doc(uid).get();
       if (value.exists) {
         _spinDate = value.get(DbKey.k_spinDate).toString();
          String date = "${time.day}/${time.month}/${time.year}";
         log(_spinDate);
         if(_spinDate.toString() == date.toString()){
           log("if");
            _isSpin = false;
            notifyListeners();
         }else{
           log("else");
           _isSpin = true;
           notifyListeners();
         }
         notifyListeners();
       } else {
         print("Not");
         _spinDate = "";
         _isSpin = true;
       }
       notifyListeners();
     } catch (e) {
       log("Error fetching account data: $e");
       if (kDebugMode) {
         print("Error fetching account data: $e");
       }
     }
     notifyListeners();
   }




   Future<void> updateUserProfile({required name, required email, required phone,
     required address,required image, required BuildContext context}) async {
     final uid = auth.currentUser?.uid;
     try {
      await firestore.collection(DbKey.c_users).doc(uid).update({
         DbKey.k_name : name,
         DbKey.k_email : email,
         DbKey.k_phone : phone,
         DbKey.k_address : address,
         DbKey.k_image : image
       }).whenComplete((){
         Provider.of<ValueProvider>(context,listen: false).setLoading(false);
         showSnackBar(title: "Profile Updated", subtitle: "");
         fetchUserProfile();
      });
       notifyListeners();
     } catch (e) {
       Provider.of<ValueProvider>(context,listen: false).setLoading(false);
       log("Error fetching account data: $e");
       if (kDebugMode) {
         print("Error fetching account data: $e");
       }
     }
     notifyListeners();
   }

  Future<void> updateLevel({required userLevel, required isLevel1, required isLevel2, required isLevel3}) async {
    log("Running");
    final uid = auth.currentUser?.uid;
    String _isLevels1 = isLevel1;
    String _isLevels2 = isLevel2;
    String _isLevels3 = isLevel3;
    String _userLevels = userLevel;

    // if(userLevel == "1"){
    //   _isLevels1 = "true";
    // }else if(userLevel == "2"){
    //   _isLevels3 = "true";
    // }else if(userLevel == "3"){
    //   _isLevels3 = "true";
    // }


    if(double.parse(_balance) > 30.0 && _isLevel1 == "false"){
      log("ennter 1");
      _userLevels = "1";
      _isLevels1 = "true";
    }else if(double.parse(_balance) > 60.0 && _isLevel2 == "false"){
      log("ennter 2");
      _isLevels3 = "true";
      _userLevels = "2";
    }if(double.parse(_balance) > 120.0 && _isLevel3 == "false"){
      log("ennter 3");
      _userLevels = "3";
      _isLevels3 = "true";
    }

    try {
      await firestore.collection(DbKey.c_users).doc(uid).update({
        DbKey.k_userLevel :  _userLevels,
        DbKey.k_isLevel1 : _isLevels1,
        DbKey.k_isLevel2 : _isLevels2,
        DbKey.k_isLevel3 : _isLevels3,
      });
      notifyListeners();
    } catch (e) {
      log("Error fetching account data: $e");
      if (kDebugMode) {
        print("Error fetching account data: $e");
      }
    }
    notifyListeners();
  }


}