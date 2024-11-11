import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.image,
    this.height = 50,
    this.width = 50, // Renamed from 'widget' to 'width'
    this.fit = BoxFit.cover, // Added fit parameter
  });

  final String image;
  final double height;
  final double width; // Renamed parameter
  final BoxFit fit; // New parameter for image fit

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      height: height,
      width: width,
      fit: fit, // Apply the fit parameter
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        ); // Show progress indicator while loading
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        print("error image ---- ${error}");
        return Icon(Icons.error, size: 50); // Placeholder for an error
      },
    );
  }
}
