import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ImageStorageService {
  ImageStorageService({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<String?> pickAndStore(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1600,
      maxHeight: 1600,
    );
    if (image == null) return null;
    final bytes = await image.readAsBytes();
    final mimeType = image.mimeType ?? _mimeTypeFor(image.name);
    return 'data:$mimeType;base64,${base64Encode(bytes)}';
  }

  String _mimeTypeFor(String name) {
    final normalized = name.toLowerCase();
    if (normalized.endsWith('.png')) return 'image/png';
    if (normalized.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }
}
