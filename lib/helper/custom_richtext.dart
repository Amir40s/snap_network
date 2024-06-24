import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
class CustomRichText extends StatelessWidget {
  final String firstText,secondText;
  final VoidCallback press;
  Color firstColor;
   double firstSize,secondSize;
  var textDecoration,highlightTextColor;
   CustomRichText({super.key,
    required this.firstText,
    required this.secondText,
    required this.press,
    this.firstSize = 12.0,
    this.firstColor = Colors.black,
    this.secondSize = 12.0,
     this.textDecoration = TextDecoration.none,
     this.highlightTextColor = primaryColor
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          text: firstText,
          style:  TextStyle(color: firstColor,fontSize: firstSize),
          children: <InlineSpan>[
            const WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: SizedBox(width: 5.0)),
            TextSpan(
              text: secondText,
              style:  TextStyle(color: highlightTextColor,fontSize: secondSize,decoration: textDecoration),
              recognizer: TapGestureRecognizer()
                ..onTap = press,
            ),
          ],
        )
    );
  }
}
