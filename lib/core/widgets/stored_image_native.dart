import 'dart:io';

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
    return Image.file(File(path), width: width, height: height, fit: fit);
  }
}
