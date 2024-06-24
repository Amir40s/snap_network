
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/provider/value/value_provider.dart';
import 'package:snap_network/res/app_assets/app_assets.dart';
import 'package:snap_network/screen/login/login_screen.dart';
import 'package:snap_network/screen/otp/otp_verify_screen.dart';


class Utils {
  /// ====== Toast Message Function ======
  void toastMessage(String message) {
    Get.snackbar(
      '',
      message,
      backgroundColor: primaryColor,
      icon: Image.asset(
        AppAssets.logo,
        width: 30,
        height: 30,
      ),
      backgroundGradient: const LinearGradient(colors: [
        Colors.orange,
        Colors.deepOrange,
        Colors.deepOrangeAccent,
      ]),
    );
  }

  snackbar({required String title, required message}) {
    Get.snackbar(
      title,
      message,
      shouldIconPulse: true,
      dismissDirection: DismissDirection.startToEnd,
      backgroundColor: Colors.green,
      icon: Image.asset(
        'assets/images/logo_transparent.png',
        width: 30,
        height: 30,
      ),
      colorText: Colors.white,
      backgroundGradient: const LinearGradient(colors: [
        Colors.orange,
        Colors.deepOrange,
        Colors.deepOrangeAccent,
      ]),
    );
  }

  showAlertDialog({
    required String desc,
    required Function() confirm,
    String? confirmText,
  }) {
    Get.defaultDialog(
      backgroundColor: Colors.deepOrange.shade400,
      middleText: desc,
      onConfirm: confirm,
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.white,
      middleTextStyle: const TextStyle(color: Colors.white),
      titleStyle: const TextStyle(color: Colors.white),
      buttonColor: Colors.white,
      textCancel: 'No',
      textConfirm: confirmText ?? 'Ok',
    );
  }

  logout() {
    Get.defaultDialog(
        title: '',
        backgroundColor: Colors.deepOrange.shade400,
        middleText: 'Sure! you want to logout?',
        onConfirm: () async {
          await auth.signOut();
         Get.offAll(LoginScreen());
        },
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.white,
        middleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
        titleStyle: const TextStyle(color: Colors.white),
        buttonColor: Colors.white,
        textCancel: 'No');
  }

  int generateUniqueNumber() {
    // Generate a random 4-digit number
    int min = 1000,max  = 9999;

    Random random = Random();
    int randomNumber = random.nextInt(max - min + 1) + min;

    // Ensure uniqueness by checking against a list of used numbers
    List<int> usedNumbers = [];
    while (usedNumbers.contains(randomNumber)) {
      randomNumber = random.nextInt(max - min + 1) + min;
    }

    // Add the generated number to the used list
    usedNumbers.add(randomNumber);

    return randomNumber;
  }

  // Send Mail function
  void sendMail({
    required String recipientEmail,
    required String otpCode,
    required BuildContext context,
     String request = "",
  }) async {
    // change your email here
    String username = 'buttgee9012@gmail.com';
    // change your password here
    String password = 'cqpi tffk whnr myzo';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Snap Network')
      ..recipients.add(recipientEmail)
      ..subject = 'One-Time OTP Verification '
      ..text = "Your Sap Network Verification Code is: $otpCode";

    try {
      await send(message, smtpServer);
      Get.snackbar("OTP SEND", "Email sent successfully");
      if(!context.mounted) return;
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      if(request == "resend"){
      }else{
       // Get.offAll(OTPVerifyScreen(otpCode: otpCode,email: recipientEmail));
      }

    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}