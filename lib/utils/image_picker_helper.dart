import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {

  ImagePickerHelper._(); // private constructor since its a helper class

  static final ImagePicker _picker = ImagePicker();

  static Future<File?> showPicker(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (bottomSheetContext) {
          return SafeArea(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galerie'),
                    onTap: () {
                      Navigator.pop(
                        bottomSheetContext,
                        ImageSource.gallery
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Caméra'),
                    onTap: () {
                      Navigator.pop(
                        bottomSheetContext,
                        ImageSource.camera
                      );
                    }
                  )
                ],
              )
          );
        }
    );
    if (source == null) {
      return null;
    }
    return pickImage(source);
  }

  static Future<File?> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  }
}