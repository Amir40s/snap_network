import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/provider/account/account_provider.dart';

import '../../../helper/image_loader_widget.dart';
import '../../../provider/image/image_provider.dart';
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
     builder: (context,provider, child){
       provider.fetchUserProfile();
       return Container(
         width: Get.width,
         padding: const EdgeInsets.all(20.0),
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10.0),
             color: primaryColor
         ),
         child: Column(
           children: [

             Consumer<ImagePickProvider>(
               builder: (context, prov, child){
                 return Stack(
                   children: [
                     GestureDetector(
                       onTap: (){
                         prov.pickProductImage();
                       },
                       child: prov.imageFile !=null ?
                       Align(
                         alignment: AlignmentDirectional.center,
                         child: CircleAvatar(
                           radius: 50.0,
                           backgroundImage: FileImage(prov.imageFile!),
                         ),
                       ) : Align(
                           alignment: AlignmentDirectional.center,
                           child: Container(
                             width: 100.0,
                             height: 100.0,
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(50.0),
                               child: ImageLoaderWidget(imageUrl: provider.profilePic,),
                             ),
                           )
                       ),
                     ),
                     Positioned(
                         left :Get.width * 0.45,
                         child: Icon(Icons.edit))
                   ],
                 );
               },
             ),
            const SizedBox(height: 10.0),
             TextWidget(text: provider.name.toString(), size: 14.0,color: Colors.black,isBold: true,),
             const SizedBox(height: 10.0),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextWidget(text: "Referral Code: ${provider.username}".toString(), size: 12.0,color: Colors.black,isBold: true),
                 SizedBox(width: 5.0,),
                 IconButton(onPressed: (){
                   Clipboard.setData(ClipboardData(text: provider.username.toString()));
                 //  showSnackBar(title: "Username Copied", subtitle: "");
                 }, icon: Icon(Icons.copy,color: Colors.black,))
               ],
             ),
           ],
         ),
       );
     },
    );
  }
}
