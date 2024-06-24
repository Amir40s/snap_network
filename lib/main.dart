import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/provider/account/account_provider.dart';
import 'package:snap_network/provider/bottomBar/bottom_bar_provider.dart';
import 'package:snap_network/provider/helpSupport/help_support_provider.dart';
import 'package:snap_network/provider/image/image_provider.dart';
import 'package:snap_network/provider/login_signup/login_signup_provider.dart';
import 'package:snap_network/provider/mining/mining_provider.dart';
import 'package:snap_network/provider/phone/phone_number_provider.dart';
import 'package:snap_network/provider/radioButton/radio_provider.dart';
import 'package:snap_network/provider/referral/referral_provider.dart';
import 'package:snap_network/provider/spinWheel/spin_wheel_provider.dart';
import 'package:snap_network/provider/tabButton/tab_button_provider.dart';
import 'package:snap_network/provider/user/user_provider.dart';
import 'package:snap_network/provider/value/password_visible_provider.dart';
import 'package:snap_network/provider/value/value_provider.dart';
import 'package:snap_network/screen/otp/otp_verify_screen.dart';
import 'package:snap_network/screen/referFriend/refer_friend_screen.dart';
import 'package:snap_network/screen/splalsh/splash_screen.dart';

import 'constant.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginSignupProvider()),
        ChangeNotifierProvider(create: (_) => ValueProvider()),
        ChangeNotifierProvider(create: (_) => BottomBarProvider()),
        ChangeNotifierProvider(create: (_) => PasswordVisibleProvider()),
        ChangeNotifierProvider(create: (_) => HelpSupportProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => SpinWheelProvider()),
        ChangeNotifierProvider(create: (_) => RadioButtonProvider()),
        ChangeNotifierProvider(create: (_) => MiningProvider(userId: auth.currentUser!.uid.toString())),
        ChangeNotifierProvider(create: (_) => CountryProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TabButtonProvider()),
        ChangeNotifierProvider(create: (_) => ReferralProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickProvider()),
      ],
      child: GetMaterialApp(
        title: 'Snap Network',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          primaryColor: primaryColor,
          useMaterial3: true,
        ),
        home:  const SplashScreen(),
      ),
    );
  }
}

