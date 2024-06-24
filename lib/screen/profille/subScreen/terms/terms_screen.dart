import 'package:flutter/material.dart';
import 'package:snap_network/helper/text_widget.dart';

import '../../../../constant.dart';
import '../../../../res/app_string/app_string.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Terms & Condition",size: 18.0,color: Colors.black,),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0,),
                TextWidget(text: "Terms & Conditions", size: 18.0,isBold: true,),
                SizedBox(height: 20.0,),
                TextWidget(text: AppString.privacyText1, size: 12.0),

                SizedBox(height: 10.0,),
                TextWidget(text: "Interpretation and Definitions", size: 18.0,isBold: true,),
                SizedBox(height: 10.0,),
                TextWidget(text: AppString.privacyText2, size: 12.0),

                SizedBox(height: 10.0,),
                TextWidget(text: "Usage Data", size: 18.0,isBold: true,),
                SizedBox(height: 10.0,),
                TextWidget(text: AppString.privacyText3, size: 12.0),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
