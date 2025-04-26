import 'dart:typed_data';

import 'package:bg_remover_fltuter/api.dart';
import 'package:bg_remover_fltuter/utils/pick_image.dart';
import 'package:flutter/material.dart';

class ApiProvider extends ChangeNotifier {
  Uint8List? imagePath;
  String? pickedFile;
  bool isLoading = false;
  Future<void> removeBackground() async {
    isLoading = true;

    try {
      final pickedImage = await pickImage();

      if (pickedImage == null) return;
      pickedFile = null;
      imagePath = null;
      notifyListeners();
      pickedFile = pickedImage;
      final res = await Api.removeBackground(pickedImage);
      if (res == null) return;
      imagePath = res;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }
}
