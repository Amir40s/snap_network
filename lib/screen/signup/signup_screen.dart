import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/custom_password_textfield.dart';
import 'package:snap_network/helper/custom_textfield_op.dart';
import 'package:snap_network/provider/phone/phone_number_provider.dart';
import 'package:snap_network/screen/login/login_screen.dart';
import 'package:snap_network/screen/otp/otp_verify_screen.dart';
import 'package:snap_network/utilis.dart';

import '../../helper/button_loading_widget.dart';
import '../../helper/button_widget.dart';
import '../../helper/custom_richtext.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/text_widget.dart';
import '../../provider/login_signup/login_signup_provider.dart';
import '../../provider/value/value_provider.dart';
import '../../res/app_assets/app_assets.dart';
class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var refController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final _key = GlobalKey<FormState>();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscurePassword2 = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<LoginSignupProvider>(context,listen: false);
    final phoneProvider = Provider.of<CountryProvider>(context);
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
                     TextWidget(text: "Full Name", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     CustomTextField(hintText: "john lewis",
                       controller: nameController,
                       keyboardType: TextInputType.name,),

                     SizedBox(height: 20.0,),
                     TextWidget(text: "Email Address", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     CustomTextField(
                       hintText: "info@example.com",
                       controller: emailController,
                       keyboardType: TextInputType.emailAddress,
                     ),

                     SizedBox(height: 20.0,),
                     TextWidget(text: "Phone Number", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     //
                     // CustomTextField(hintText: "+123 456 7890", controller: phoneController,keyboardType: TextInputType.number,),



                     Row(
                       children: [
                         Expanded(
                           child: GestureDetector(
                             onTap: () {
                               showCountryPicker(
                                 context: context,
                                 showPhoneCode: true,
                                 onSelect: (Country country) {
                                   phoneProvider.setCountryCode('+${country.phoneCode}');
                                 },
                               );
                             },
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                               decoration: BoxDecoration(
                                 border: Border.all(color: Colors.grey),
                                 borderRadius: BorderRadius.circular(8.0),
                               ),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Text(phoneProvider.selectedCountryCode),
                                   Icon(Icons.arrow_drop_down),
                                 ],
                               ),
                             ),
                           ),
                         ),
                         SizedBox(width: 3.0),
                         Expanded(
                           flex: 3,
                           child: TextField(
                             controller: phoneController,
                             decoration: InputDecoration(
                               labelText: 'Phone Number',
                               // prefixText: phoneProvider.selectedCountryCode + ' ',
                             ),
                             keyboardType: TextInputType.phone,
                           ),)
                       ],
                     ),
                     SizedBox(height: 16.0),
                     // TextField(
                     //   decoration: InputDecoration(
                     //     labelText: 'Phone Number',
                     //     prefixText: phoneProvider.selectedCountryCode + ' ',
                     //   ),
                     //   keyboardType: TextInputType.phone,
                     // ),

                     SizedBox(height: 20.0,),
                     TextWidget(text: "Referral Code", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     CustomTextFieldOP(hintText: "Referral Code", controller: refController,keyboardType: TextInputType.text,),

                     SizedBox(height: 20.0,),
                     TextWidget(text: "Password", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     CustomPasswordTextField(hintText: "*********", controller: passwordController,obscurePassword: _obscurePassword,),

                     SizedBox(height: 20.0,),
                     TextWidget(text: "Confirm Password", size: 16.0,isBold: true,),
                     SizedBox(height: 10.0,),
                     CustomPasswordTextField(hintText: "*********", controller: confirmPasswordController,obscurePassword: _obscurePassword2,),

                     SizedBox(height: 30.0,),
                     Consumer<ValueProvider>(
                       builder: (context, provider, child){
                         return provider.isLoading == false  ? ButtonWidget(text: "Sign Up", onClicked: (){
                           if(_key.currentState!.validate()){
                             if(passwordController.text == confirmPasswordController.text){
                               if(passwordController.text.length >=8){
                                 // phoneProvider.register();
                                // provider.setLoading(true);
                                 final otp = Utils().generateUniqueNumber();
                                 Utils().sendMail(
                                     recipientEmail: emailController.text.toString().trim(), otpCode: otp.toString(), context: context);
                                 Get.to(OTPVerifyScreen(
                                   otpCode: otp.toString(),
                                   email: emailController.text.toString().trim(),
                                   name: nameController.text.toString().trim(),
                                   phone: "${phoneProvider.selectedCountryCode..toString()}${phoneController.text.toString()}",
                                   password: passwordController.text.toString(),
                                   referral: refController.text.toString().trim()
                                 ));
                                 // Provider.of<LoginSignupProvider>(context,listen: false)
                                 //     .createUserAccount(
                                 //     referral: refController.text.toString().trim(),
                                 //     name: nameController.text.toString().trim(),
                                 //     phone: "${phoneProvider.selectedCountryCode..toString()}${phoneController.text.toString()}",
                                 //     email: emailController.text.toString().trim(),
                                 //     password: passwordController.text.toString().trim(),
                                 //     context: context);
                               }else{
                                 showSnackBar(title: "Alert!!!", subtitle: "password must be at least 8 characters");
                               }
                             }else{
                               showSnackBar(title: "Alert!!!", subtitle: "Password not match");
                             }

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
                         Get.to(LoginScreen());
                       }, firstText: "Already have an account?", secondText: "Login"),
                     )

                   ],
                 ),
               ),
             ),
           ),
         ],
        ),
      ),
    );
  }
}
