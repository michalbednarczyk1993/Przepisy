import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImageStorageService {
  ImageStorageService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<String?> pickAndStore(ImageSource source) async {
    final image = await _picker.pickImage(source: source, imageQuality: 85);
    if (image == null) return null;
    final dir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(dir.path, 'recipe_images'));
    if (!await imagesDir.exists()) await imagesDir.create(recursive: true);
    final extension = p.extension(image.path).isEmpty ? '.jpg' : p.extension(image.path);
    final target = File(p.join(imagesDir.path, 'recipe_${DateTime.now().millisecondsSinceEpoch}$extension'));
    await File(image.path).copy(target.path);
    return target.path;
  }
}
