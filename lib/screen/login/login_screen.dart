import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/button_widget.dart';
import 'package:snap_network/helper/custom_password_textfield.dart';
import 'package:snap_network/helper/custom_richtext.dart';
import 'package:snap_network/helper/custom_textfield.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/provider/login_signup/login_signup_provider.dart';
import 'package:snap_network/res/app_assets/app_assets.dart';

import '../../helper/button_loading_widget.dart';
import '../../provider/value/value_provider.dart';
import '../forgot/forgot_screen.dart';
import '../signup/signup_screen.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

   final _key = GlobalKey<FormState>();
   final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<LoginSignupProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
         children: [
           Container(
             color: Colors.black,
             height: Get.width / 1.5,
             child: Center(child: Image.asset(AppAssets.logo,height: Get.width / 1.5,)),
           ),
           Container(
             margin: EdgeInsets.only(top: Get.width / 1.5),
             padding: EdgeInsets.all(20.0),
             height: Get.height,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(20.0),
                 topRight: Radius.circular(20.0),
               )
             ),
             child: SingleChildScrollView(
               child: Form(
                 key: _key,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     TextWidget(text: "let's Get Started", size: 32, isBold: true,),
                     SizedBox(height: 10.0,),
                     TextWidget(text: "Sign up or long in What's \nHapping nery you", size: 24,),
                     SizedBox(height: 20.0,),
                     TextWidget(text: "Email Address", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     CustomTextField(hintText: "info@example.com", controller: emailController),

                     SizedBox(height: 20.0,),
                     TextWidget(text: "Password", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     CustomPasswordTextField(hintText: "*********",
                       controller: passwordController, obscurePassword: _obscurePassword,),

                     SizedBox(height: 20.0,),
                     GestureDetector(
                       onTap: (){

                         Get.to(ForgotPasswordScreen());
                       },
                       child: Align(
                           alignment: AlignmentDirectional.topEnd,
                           child: TextWidget(text: "forgot password?", size: 12.0,isBold: true,)),
                     ),
                     SizedBox(height: 30.0,),
                     Consumer<ValueProvider>(
                       builder: (context, provider, child){
                         return provider.isLoading == false  ? ButtonWidget(text: "Login", onClicked: (){
                           if(_key.currentState!.validate()){
                             _key.currentState!.save();
                             provider.setLoading(true);
                             firebaseProvider.signInWithGoogle(
                                 email: emailController.text.toString().trim(),
                                 password: passwordController.text.toString().trim(),
                                 context: context
                             );
                           }


                         }, width: Get.width, height: 50.0) :
                         ButtonLoadingWidget(
                             loadingMesasge: "login",
                             width: MediaQuery.sizeOf(context).width,
                             height: 50.0
                         );
                       },
                     ),
                     SizedBox(height: 30.0,),
                     Align(
                       alignment: AlignmentDirectional.center,
                       child: CustomRichText(press: (){
                         Get.to(SignupScreen());
                       }, firstText: "Don't have an account?", secondText: "Sign Up"),
                     )

                   ],
                 ),
               ),
             ),
           )
         ],
        ),
      ),
    );
  }
}
