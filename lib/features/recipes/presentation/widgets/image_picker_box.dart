import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/image_storage_service.dart';

class ImagePickerBox extends StatefulWidget {
  const ImagePickerBox({required this.onChanged, super.key, this.path});
  final String? path;
  final ValueChanged<String> onChanged;

  @override
  State<ImagePickerBox> createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<ImagePickerBox> {
  final service = ImageStorageService();
  String? currentPath;

  @override
  void initState() {
    super.initState();
    currentPath = widget.path;
  }

  Future<void> pick(ImageSource source) async {
    final path = await service.pickAndStore(source);
    if (path != null) {
      setState(() => currentPath = path);
      widget.onChanged(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = currentPath == null
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate_outlined),
              SizedBox(height: 8),
              Text('Dodaj zdjęcie'),
              Text('JPG, PNG'),
            ],
          )
        : Image.file(
            File(currentPath!),
            fit: BoxFit.cover,
            width: double.infinity,
          );
    return InkWell(
      onTap: () => pick(ImageSource.gallery),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
