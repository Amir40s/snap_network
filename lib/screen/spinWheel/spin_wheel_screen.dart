import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/db_key.dart';
import 'package:snap_network/helper/button_widget.dart';
import 'package:snap_network/helper/coupons_card.dart';
import 'package:snap_network/provider/account/account_provider.dart';
import 'package:snap_network/provider/spinWheel/spin_wheel_provider.dart';
import 'package:snap_network/res/app_string/app_string.dart';
import 'dart:math';

import '../../constant.dart';
import '../../helper/text_widget.dart';

class SpinWheelScreen extends StatefulWidget {
  @override
  _SpinWheelScreenState createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.addListener(() {
      double spinValue = _animation.value * 2 * pi;
      Provider.of<SpinWheelProvider>(context, listen: false).setSpinValue(spinValue);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        String prize = Provider.of<SpinWheelProvider>(context, listen: false).getPrize();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You won: $prize')),
        );
        saveFirebaseData(prize);
      }
    });
  }

  void _spinWheel() {
    Provider.of<AccountProvider>(context,listen: false).setSpinDate(false);
    double randomValue = Random().nextDouble() * 6 + 10; // Random spins
    _controller.reset();
    _animation = Tween<double>(begin: 0, end: randomValue).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountProvider>(context,listen: false);
    provider.getSpin();
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: TextWidget(text: "Spin Wheel",size: 18.0,color: Colors.black,),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CouponsCard(),
              SizedBox(height: 10.0,),
              Consumer<SpinWheelProvider>(
                builder: (context, provider, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.rotate(
                              angle: provider.spinValue,
                              child: Container(
                                width: 390,
                                height: 390,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/spin_wheel_image.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            ..._buildWheelLabels(provider.spinValue),
                            Positioned(
                              top: 140,
                              child: Icon(
                                Icons.arrow_drop_up,
                                size: 40,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),

                        Consumer<AccountProvider>(
                         builder: (context, provider, child){
                           return Visibility(
                             visible: provider.isSpin,
                             child: ButtonWidget(
                               text: "Click here to spin",
                               onClicked: _spinWheel,
                               textColor: Colors.black,
                               width: Get.width /2,
                               height: 50.0,
                               radius: 10.0,
                             ),
                           );
                         },
                        ),
                        SizedBox(height: 10.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(text: AppString.spinText, size: 12.0,textAlignment: TextAlign.center,),
                        ),
                        
                      ],
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWheelLabels(double angle) {
    const segmentValues = [
      '0.00100',
      '0.00200',
      '0.00300',
      '0.00400',
      '0.00500',
      '0.00350',
      '0.00300',
      '0.00500'
    ];

    const segmentAngles = [pi / 4, 3 * pi / 4, 5 * pi / 4, 7 * pi / 4];

    return List<Widget>.generate(segmentValues.length, (index) {
      double segmentAngle = index * pi / 4;

      // Rotating the segment text to be upright
      return Transform.rotate(
        angle: segmentAngle - angle,
        child: Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: Offset(
              12,
              -70, // Adjust the radius according to your wheel size
            ),
            child: Transform.rotate(
              angle: -80,
              child: Text(
                segmentValues[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void saveFirebaseData(String prize) async{
    DateTime time = DateTime.now();
    String? userUID = auth.currentUser?.uid;
    String UserBalance = "0.0";
    await firestore.collection("users").doc(userUID).get().then((value){
      UserBalance = value.get(DbKey.k_balance).toString();
    });
   firestore.collection(DbKey.c_spins).doc(auth.currentUser?.uid).set({
     DbKey.k_spinDate : "${time.day}/${time.month}/${time.year}",
     DbKey.k_prize : prize.toString(),
   }).whenComplete((){
     final provider = Provider.of<AccountProvider>(context,listen: false);
     firestore.collection(DbKey.c_spins).doc(auth.currentUser?.uid).collection("spins").add({
       DbKey.k_spinDate : "${time.day}/${time.month}/${time.year}",
       DbKey.k_prize : prize.toString(),
     });
     debugPrint("Spin Provider Value: ${provider.balance}");
     double value = double.parse(UserBalance) + double.parse(prize);
    debugPrint("Spin Value: $value");
     firestore.collection("users").doc(userUID).update({
       "balance" : value.toString(),
     });
     firestore.collection("mining").doc(userUID).update({
       "walletBalance" : value.toDouble(),
     });
     Provider.of<AccountProvider>(context,listen: false).getSpin();
   });
   }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:snap_network/provider/spinWheel/spin_wheel_provider.dart';
// import 'dart:math';
//
// import '../../constant.dart';
// import '../../helper/text_widget.dart';
//
//
// class SpinWheelScreen extends StatefulWidget {
//   @override
//   _SpinWheelScreenState createState() => _SpinWheelScreenState();
// }
//
// class _SpinWheelScreenState extends State<SpinWheelScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     );
//
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOut,
//     );
//
//     _controller.addListener(() {
//       double spinValue = _animation.value * 2 * pi;
//       Provider.of<SpinWheelProvider>(context, listen: false).setSpinValue(spinValue);
//     });
//
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         // Compute the prize when the animation stops
//         String prize = Provider.of<SpinWheelProvider>(context, listen: false).getPrize();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('You won: $prize')),
//         );
//       }
//     });
//   }
//
//   void _spinWheel() {
//     double randomValue = Random().nextDouble() * 6 + 10; // Random spins
//     _controller.reset();
//     _animation = Tween<double>(begin: 0, end: randomValue).animate(_controller);
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: TextWidget(text: "Wheel Bonus",size: 18.0,color: Colors.white,),
//         centerTitle: true,
//         backgroundColor: primaryColor,
//         elevation: 0.0,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 Consumer<SpinWheelProvider>(
//                   builder: (context, provider, child) {
//                     return Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Transform.rotate(
//                           angle: provider.spinValue,
//                           child: CustomPaint(
//                             size: Size(200 , 200),
//                             painter: SpinWheelPainter(),
//                           ),
//                         ),
//                         Positioned(
//                           top: 270,
//                           left: 190,
//                           child: Container(
//                             width: 20,
//                             height: 20,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(
//                               child: Icon(
//                                 Icons.arrow_drop_down,
//                                 size: 12,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: _spinWheel,
//                   child: Text('Click here to Spin'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



class SpinWheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    const segmentValues = [
      '0.00100\ncoin',
      '0.00200\ncoin',
      '0.00300\ncoin',
      '0.00400\ncoin',
      '0.00500\ncoin',
      '0.00350\ncoin',
      '0.00300\ncoin',
      '0.00500\ncoin'
    ];
    const colors = [
      Colors.orange,
      Colors.white,
      Colors.orange,
      Colors.white,
      Colors.orange,
      Colors.white,
      Colors.orange,
      Colors.white
    ];

    Paint segmentPaint = Paint()
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      double startAngle = i * pi / 4;
      segmentPaint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        pi / 4,
        true,
        segmentPaint,
      );

      drawTextAlongArc(canvas, size, radius, startAngle, segmentValues[i]);
    }
  }

  void drawTextAlongArc(Canvas canvas, Size size, double radius, double startAngle, String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    double textAngle = startAngle + pi / 8;
    double textRadius = radius - 40; // Adjust to position the text closer or further

    final textOffset = Offset(
      radius + textRadius * cos(textAngle) - textPainter.width / 2,
      radius + textRadius * sin(textAngle) - textPainter.height / 2,
    );

    canvas.save();
    canvas.translate(textOffset.dx, textOffset.dy);
    canvas.rotate(textAngle - pi / 2); // Rotate text to align with the arc
    textPainter.paint(canvas, Offset(0, 0));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}






