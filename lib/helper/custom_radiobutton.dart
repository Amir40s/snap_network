// lib/custom_radio_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/provider/radioButton/radio_provider.dart';
import 'package:snap_network/res/app_icons/app_icons.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;
  final String groupValue,text,image;
  final ValueChanged<String> onChanged;

  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged, required this.text, required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Consumer<RadioButtonProvider>(
        builder: (context, provider, child){
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    isSelected
                        ? Icon(
                      Icons.radio_button_checked,
                      size: 24.0,
                      color: primaryColor,
                    )
                        : Icon(
                      Icons.radio_button_unchecked,
                      size: 24.0,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10.0),
                    TextWidget(text: text, size: 12.0)
                  ],
                ),
                Image.asset(image,width: 24,height: 24,),

                
              ],
            ),
          );
        },
      ),
    );
  }
}
