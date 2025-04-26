import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
  try {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return null;
    return pickedImage.path;
  } on PlatformException catch (err) {
    print(err.toString());
  }
  return null;
}
