// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// class AppNetworkImage extends StatelessWidget {
//   const AppNetworkImage({super.key, this.fit = BoxFit.cover,  required this.src,  this.width = 100, this.height = 100});
//   final String src;
//   final double width;
//   final double height;
//   final BoxFit fit;
//
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: src,
//       fit: fit,
//       width: width,
//       height: height,
//       progressIndicatorBuilder: (context, url, downloadProgress) =>
//           CircularProgressIndicator(value: downloadProgress.progress),
//       errorWidget: (context, url, error) => Icon(Icons.error),
//     );
//   }
// }
