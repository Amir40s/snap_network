import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant/random.dart';

import '../../constant.dart';
import '../../db_key.dart';
import '../../screen/bottomBar/bottom_bar_screen.dart';
import '../../screen/login/login_screen.dart';
import '../account/account_provider.dart';
import '../value/value_provider.dart';



class LoginSignupProvider extends ChangeNotifier{


  // create user new account
  Future<void> createUserAccount(
      {required name, required phone, required email,required password,required referral,required  context}) async {
    log("message $email $password $referral $phone");
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).whenComplete((){
        saveUserAccount(name: name,phone: phone,email: email, password: password,referral: referral,context: context);
      });

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Provider.of<ValueProvider>(context,listen: false).setLoading(false);
        Get.snackbar("Failed!!!!","The password provided is too weak");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Provider.of<ValueProvider>(context,listen: false).setLoading(false);
        Get.snackbar("Failed!!!!","The account already exists for that email.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }


  // save new user accomt data to database
  Future<void> saveUserAccount(
      {required name, required phone, required email,required password,required referral, required context}) async {
    DateTime time = DateTime.now();
    try {
      if(auth.currentUser?.uid!=null){
        firestore.collection(DbKey.c_users).doc(auth.currentUser?.uid.toString())
            .set({
          DbKey.k_name : name,
          DbKey.k_phone : phone,
          DbKey.k_email : email,
          DbKey.k_password : password,
          DbKey.k_referral : referral,
          DbKey.k_wallet : "",
          DbKey.k_isLevel1 : "false",
          DbKey.k_isLevel2 : "false",
          DbKey.k_isLevel3 : "false",
          DbKey.k_userLevel : "0",
          DbKey.k_balance : "0",
          "profilePic" : "",
          DbKey.k_mining : "end",
          DbKey.k_miningUnit : "0",
          DbKey.k_userUID : auth.currentUser?.uid.toString(),
          DbKey.k_username : generateRandomString(6).toString(),
          DbKey.k_date : "${time.day}/${time.month}/${time.year}",
          DbKey.k_time : "${time.hour}:${time.minute}",
          DbKey.k_timestamp : time.millisecondsSinceEpoch,
        }).whenComplete(() {
          Provider.of<ValueProvider>(context,listen: false).setLoading(false);
          Get.snackbar("Account Created Successfully","Thanks for creating your account");
          Get.to(()=> LoginScreen());
        });
      }
      notifyListeners();
    } catch (e) {
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> signInWithGoogle({required email,required password,required BuildContext context}) async{
    //  final provider = Provider.of<SharedPreferenceProvider>(context,listen: false);
    try {
      final user =   await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      if(user.user!.uid.isNotEmpty){
        Provider.of<ValueProvider>(context,listen: false).setLoading(false);
        await Provider.of<AccountProvider>(context,listen: false).fetchUserProfile();
       Get.offAll(()=> const BottomBarScreen());
      }else{
        Provider.of<ValueProvider>(context,listen: false).setLoading(false);
        Get.snackbar("Error", "invalid credentials");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Provider.of<ValueProvider>(context,listen: false).setLoading(false);
        print('No user found for that email.');
        Get.snackbar("Error", "No Email Found against");
      } else if (e.code == 'wrong-password') {
        Provider.of<ValueProvider>(context,listen: false).setLoading(false);
        Get.snackbar("something wrong", "Please enter correct password.");
        print('Wrong password provided for that user.');
      }
    }finally{
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    }

  }

  Future<void> resetPassword({required email,required BuildContext context}) async{

    try{
      auth.sendPasswordResetEmail(email: email).whenComplete(() {
        Provider.of<ValueProvider>(context,listen: false).setLoading(false);
        Get.snackbar("Link Send Successfully", "please check your inbox");
      });
    }catch(e){
      print(e);
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    }


  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

}