import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final dynamic image;
  const ImageView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: PhotoView(
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              imageProvider:
                  (image is Uint8List)
                      ? MemoryImage(image)
                      : FileImage(File(image)) as ImageProvider,
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
