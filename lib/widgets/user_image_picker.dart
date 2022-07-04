import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function pickedImageFn;

  UserImagePicker(this.pickedImageFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage(ImageSource src) async {
    final PickedFile _pickedFile = await ImagePicker()
        .getImage(source: src, imageQuality: 50, maxWidth: 150);
    if (_pickedFile != null) {
      setState(() {
        _pickedImage = File(_pickedFile.path);
      });
      widget.pickedImageFn(_pickedImage);
    } else {
      print("no image picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.photo_camera_outlined),
                label: Text("Add image\nfrom camera")),
            FlatButton.icon(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                icon: Icon(Icons.image_outlined),
                label: Text("Add image\nfrom Gallery")),
          ],
        )
      ],
    );
  }
}
