import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/model/user/user_model.dart';
import 'package:snap_network/provider/account/account_provider.dart';

import '../../constant.dart';
import '../../db_key.dart';

class UserProvider extends ChangeNotifier{

  Stream<List<UserModel>> getProducts({required BuildContext context, required status}) {
    final username = Provider.of<AccountProvider>(context,listen: false).username.toString();
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection('users')
        .where("referral", isEqualTo: username)
        .where("mining", isEqualTo: status)
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

}