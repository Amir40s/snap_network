import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helper/text_widget.dart';
class PriceDetailsRows extends StatelessWidget {
  final String text;
  IconData icons;
  bool isCredit;
   PriceDetailsRows({super.key,
    required this.text,
     this.isCredit = false,
     this.icons = Icons.done,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isCredit ? Colors.red : Colors.black,
            ),
            child:  Icon(isCredit ? Icons.close : icons ,color: Colors.white,size: 10.0,),
          ),
          SizedBox(width: 8.0,),
          TextWidget(text: text, size: 12.0),
        ],
      ),
    );
  }
}
