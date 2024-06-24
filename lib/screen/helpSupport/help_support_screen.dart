import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/provider/helpSupport/help_support_provider.dart';

import '../../constant.dart';
import '../../helper/text_widget.dart';
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = Provider.of<HelpSupportProvider>(context,listen: false).faqs;

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: TextWidget(text: "Support",size: 18.0,color: Colors.black,),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.0,),
                TextWidget(text: "Support", size: 22.0,color: Colors.black,isBold: true,),
                SizedBox(height: 40.0,),
                ListView.builder(
                  itemCount: faqs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final faq = faqs[index];
                    return ExpansionTile(
                      title: Text(faq.question),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(faq.answer),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
