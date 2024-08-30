import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});
  final void Function(File pickedImage) onPickImage;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueGrey,
            //the foreground image wants an image provider which is FileImage returns so thats why we do not use ImageFile cuz that returns a widget
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null),
        TextButton.icon(
            onPressed: _pickImage,
            label: Text(
              'Add Image',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            icon: const Icon(Icons.image))
      ],
    );
  }
}
