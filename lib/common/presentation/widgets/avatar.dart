import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const Avatar({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
