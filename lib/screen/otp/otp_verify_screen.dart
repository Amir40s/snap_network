import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../helper/button_loading_widget.dart';
import '../../helper/button_widget.dart';
import '../../helper/custom_richtext.dart';
import '../../helper/text_widget.dart';
import '../../provider/login_signup/login_signup_provider.dart';
import '../../provider/value/value_provider.dart';
import '../../utilis.dart';


class OTPVerifyScreen extends StatelessWidget {
   String otpCode,email,name,password,phone,referral;
  OTPVerifyScreen({super.key,
  required this.otpCode,
    required this.email,
    required this.name,
    required this.password,
    required this.phone
    ,required this.referral
  });

   var otp1Controller = TextEditingController();
   var otp2Controller = TextEditingController();
   var otp3Controller = TextEditingController();
   var otp4Controller = TextEditingController();
  final _formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    log("Parameter: $email $password $phone $referral $name");
    final valueProvider = Provider.of<ValueProvider>(context,listen: false);
    double height20px = 20.0;
    double height30px = 30.0;
    print(otpCode);
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height20px,),
                   BackButton(),
            
                  SizedBox(height: height20px,),
                  Container(
                      width: Get.width,
                      alignment: AlignmentDirectional.center,
                      child: CustomRichText(press: (){}, firstText: "We sent an OTP to your", secondText: "Email Address")),
                  SizedBox(height: height30px,),
                  TextWidget(text: "Enter Code", size: 12.0,isBold: true,),
                  SizedBox(height: height20px,),
            
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 64.0,
                          height: 68.0,
                          child: TextFormField(
                            controller: otp1Controller,
                            onChanged: (value){
                              if (value.length == 1){
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "0",
                              enabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
                              ),
                              hintStyle: const TextStyle(fontSize: 12.0,color: Colors.grey),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 64.0,
                          height: 68.0,
                          child: TextFormField(
                            controller: otp2Controller,
                            onChanged: (value){
                              if (value.length == 1){
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "0",
                              enabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
                              ),
                              hintStyle: const TextStyle(fontSize: 12.0,color: Colors.grey),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 64.0,
                          height: 68.0,
                          child: TextFormField(
                            controller: otp3Controller,
                            onChanged: (value){
                              if (value.length == 1){
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "0",
                              enabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
                              ),
                              hintStyle: const TextStyle(fontSize: 12.0,color: Colors.grey),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 64.0,
                          height: 68.0,
                          child: TextFormField(
                            controller: otp4Controller,
                            onChanged: (value){
                              if (value.length == 1){
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "0",
                              enabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
                              ),
                              hintStyle: const TextStyle(fontSize: 12.0,color: Colors.grey),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            
            
            
                  SizedBox(height: 90.0,),
                  Container(
                      width: Get.width,
                      alignment: AlignmentDirectional.center,
                      child: CustomRichText(press: (){
                        Get.snackbar("Request submitted", "");
                        int otp = Utils().generateUniqueNumber();
                        otpCode = otp.toString();
                        print(otpCode);
                        Utils().sendMail(recipientEmail: email, otpCode: otp.toString(), context: context,request: "resend");
                      },
                        firstText: "Didn't receive?",
                        secondText: "Resend",
                        textDecoration: TextDecoration.underline,
                        highlightTextColor: Colors.black,
                      )),
                  SizedBox(height: height30px,),
                  Consumer<ValueProvider>(
                    builder: (context, provider, child){
                      return provider.isLoading == false  ? ButtonWidget(text: "Verify", onClicked: (){
                        if (_formKey.currentState!.validate()){
                          valueProvider.setLoading(true);
                          final otp = otp1Controller.text.toString() + otp2Controller.text.toString() +
                              otp3Controller.text.toString() + otp4Controller.text.toString();
                          if(otp == otpCode){
                            log(email);
                            // valueProvider.setLoading(true);
                            Provider.of<LoginSignupProvider>(context,listen: false)
                                .createUserAccount(
                                referral: referral,
                                name: name,
                                phone: phone,
                                email: email,
                                password: password,
                                context: context);
                            // Get.offAll(HomeScreen());
            
                          }else{
                            valueProvider.setLoading(false);
                            Get.snackbar("Verification Failed", "Please check your otp code");
                          }
                        }
            
            
                      }, width: Get.width, height: 50.0) :
                      ButtonLoadingWidget(
                          loadingMesasge: "verifying",
                          width: MediaQuery.sizeOf(context).width,
                          height: 50.0
                      );
                    },
                  ),
                  // ButtonWidget(text: "verify", onClicked: (){
                  //   if (_formKey.currentState!.validate()){
                  //     valueProvider.setLoading(true);
                  //     final otp = otp1Controller.text.toString() + otp2Controller.text.toString() +
                  //                otp3Controller.text.toString() + otp4Controller.text.toString();
                  //     if(otp == otpCode){
                  //       print(email);
                  //       valueProvider.setLoading(false);
                  //       // Get.offAll(HomeScreen());
                  //
                  //     }else{
                  //       valueProvider.setLoading(false);
                  //       Get.snackbar("Verification Failed", "Please check your otp code");
                  //     }
                  //   }
                  // }, width: Get.width, height: 50.0,)
                ],
              ),
            ),
          ),
        )
    );
  }
}
