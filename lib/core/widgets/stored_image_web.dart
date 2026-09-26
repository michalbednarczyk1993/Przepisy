import 'package:flutter/material.dart';

class StoredImage extends StatelessWidget {
  const StoredImage({
    required this.path,
    required this.fit,
    super.key,
    this.width,
    this.height,
  });

  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => ColoredBox(
        color: Colors.green.shade50,
        child: const Center(child: Icon(Icons.broken_image_outlined)),
      ),
    );
  }
}
