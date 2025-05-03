import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CachedImagePersistent extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const CachedImagePersistent({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: double.infinity,
      fadeInDuration: Duration.zero,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: 400, 
          color: Colors.grey.shade300,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
