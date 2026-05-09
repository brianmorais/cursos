import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  void imageSelected(PickedFile image) async {
    if (image != null) {
      File croopedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      );
      onImageSelected(croopedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _imagePicker = ImagePicker();
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () async {
              PickedFile file = await _imagePicker.getImage(
                source: ImageSource.camera,
              );
              imageSelected(file);
            },
            child: Text('Câmera'),
          ),
          TextButton(
            onPressed: () async {
              PickedFile file = await _imagePicker.getImage(
                source: ImageSource.gallery,
              );
              imageSelected(file);
            },
            child: Text('Galeria'),
          ),
        ],
      ),
    );
  }
}
