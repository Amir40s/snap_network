// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:snap_network/model/referralUser/referral_user_model.dart';
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   Future<List<ReferralUserModel>> getUsersWithReferralCount() async {
//     QuerySnapshot snapshot = await _db.collection('users').get();
//
//     List<ReferralUserModel> users = snapshot.docs.map((doc) {
//       return ReferralUserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
//     }).toList();
//     // Calculate referral counts
//     for (var user in users) {
//       user.referralCount = users.where((u) => u.referral == user.username).length;
//     }
//
//     // Sort users by referral count in descending order
//     users.sort((a, b) => b.referralCount.compareTo(a.referralCount));
//
//     return users;
//   }
// }
//
//
// class ReferralProvider with ChangeNotifier {
//   final FirestoreService _firestoreService = FirestoreService();
//   List<ReferralUserModel> _users = [];
//
//   List<ReferralUserModel> get users => _users;
//
//   ReferralProvider() {
//     fetchUsers();
//   }
//
//   Future<void> fetchUsers() async {
//     _users = await _firestoreService.getUsersWithReferralCount();
//     log("In Provider: $_users");
//     notifyListeners();
//   }
// }
//

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:snap_network/model/referralUser/referral_user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ReferralUserModel>> getUsersWithReferralCount() async {
    QuerySnapshot snapshot = await _db.collection('users').get();

    List<ReferralUserModel> users = snapshot.docs.map((doc) {
      return ReferralUserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    // Calculate referral counts
    for (var user in users) {
      user.referralCount = users.where((u) => u.referral == user.username).length;
    }

    // Sort users by referral count in descending order
    users.sort((a, b) => b.referralCount.compareTo(a.referralCount));

    return users;
  }

  Future<List<ReferralUserModel>> getTopThreeUsers() async {
    List<ReferralUserModel> users = await getUsersWithReferralCount();

    // Return the top 3 users
    return users.take(3).toList();
  }
}

class ReferralProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<ReferralUserModel> _users = [];

  List<ReferralUserModel> get users => _users;
  List<ReferralUserModel> _topThreeUsers = [];

  List<ReferralUserModel> get topThreeUsers => _topThreeUsers;

  ReferralProvider() {
    fetchUsers();
    fetchTopThreeUsers();
  }

  Future<void> fetchUsers() async {
    _users = await _firestoreService.getUsersWithReferralCount();
    log("In Provider (All Users): $_users");
    notifyListeners();
  }

  Future<void> fetchTopThreeUsers() async {
    _topThreeUsers = await _firestoreService.getTopThreeUsers();
    log("In Provider (Top 3 Users): $_topThreeUsers");
    notifyListeners();
  }
}
