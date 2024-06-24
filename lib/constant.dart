import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snap_network/screen/login/login_screen.dart';


const primaryColor = Color(0xFFFFCB07);
const darkPurple = Color(0xFF7132F5);
const secondaryColor = Color(0xFFF857A6);
const orangeColor = Color(0xFFE25D6C);
const whiteColor = Color(0xFFFFFFFF);
const lightPink = Color(0xFFC1839F);
const bgColor = Color(0xFFFBF9F9);
const drawerBackground = Color(0xFF212332);
const lightGrey = Color(0xFFE2E8F0);
const darkGrey = Color(0xFF534F5D);
const lightBlue = Colors.lightBlue;
const Color customGrey = Color(0xFFE0E0E0);

const Color blue = Color(0xFF0063F5);
const Color orange = Color(0xFFF59300);
const Color purple = Color(0xFF9300F5);
const Color pink = Color(0xFFF50062);



LinearGradient gradientColor = const LinearGradient(colors: [

  Color(0xff0fabaa),
  Color(0xff3EC2C2),
  Color(0xff40d5d4),
  Color(0xff8ae5e5),
  // Color(0xffFFFFFF),
]);

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

void showSnackBar({required title, required subtitle}){
  Get.snackbar(title, subtitle,colorText: Colors.black);
}


logout(){
  auth.signOut().then((value){
    Get.offAll(()=> LoginScreen());
  }).catchError((e){
    Get.offAll(()=> LoginScreen());
  });
}

customDialog({required VoidCallback onClick,required title,required content
  ,  textYes = "Yes", textNo = "No"}){
  Get.defaultDialog(
    title: title,
    content: Text(content),
    textCancel: textNo,
    textConfirm: textYes,
    onConfirm: onClick,
  );
}

String maskEmail(String email) {
  // Check if the email has at least 3 characters before the '@' symbol
  if (email.isEmpty) return email;
  int atIndex = email.indexOf('@');
  if (atIndex < 2) {
    // If the email is shorter than 3 characters before '@', return as is.
    return email;
  }
  String visiblePart = email.substring(0, 2); // First 3 characters
  String maskedPart = '*' * (atIndex - 2); // Mask the rest until '@'
  String domain = email.substring(atIndex); // Include domain part

  return visiblePart + maskedPart + domain;
}

String formatNumber(String number) {
  return double.parse(number).toStringAsFixed(2);
}

double extractNumber(String input) {
  final RegExp regex = RegExp(r'\d+(\.\d+)?');
  final match = regex.firstMatch(input);
  if (match != null) {
    return double.parse(match.group(0)!);
  }
  throw ArgumentError("No valid number found in input string.");
}