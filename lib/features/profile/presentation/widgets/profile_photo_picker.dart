import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePhotoPicker extends StatefulWidget {
  final void Function(String imagePath) onImagePicked;
  final String? initialImagePath;
  final double size;

  const ProfilePhotoPicker({
    super.key,
    required this.onImagePicked,
    this.initialImagePath,
    this.size = 240,
  });

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final appDir = await getApplicationDocumentsDirectory();
      final now = DateTime.now();
      final formattedTime =
          '${now.year}${_twoDigits(now.month)}${_twoDigits(now.day)}_${_twoDigits(now.hour)}${_twoDigits(now.minute)}${_twoDigits(now.second)}';
      final fileName = 'profile_photo_$formattedTime${extension(pickedFile.path)}';
      final savedPath = join(appDir.path, fileName);

      final savedImage = await imageFile.copy(savedPath);

      setState(() {
        _imagePath = savedImage.path;
      });
      widget.onImagePicked(savedImage.path);
    }
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: widget.size / 2,
        backgroundImage:
            _imagePath != null ? FileImage(File(_imagePath!)) : null,
        child: _imagePath == null
            ? Icon(Icons.camera_alt, size: widget.size / 3)
            : null,
      ),
    );
  }
}
