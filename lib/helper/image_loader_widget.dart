import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snap_network/res/app_assets/app_assets.dart';



class ImageLoaderWidget extends StatelessWidget {
  final String imageUrl;
  const ImageLoaderWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => CircularProgressIndicator(color: Colors.grey,), // Path to your placeholder image
      errorWidget: (context, url, error) => Image.asset(AppAssets.logo), // Display an error icon if the image fails to load
      fit: BoxFit.cover,
    );
  }
}
