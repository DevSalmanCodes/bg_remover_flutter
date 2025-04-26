import 'dart:io';

import 'package:bg_remover_fltuter/providers/api_provider.dart';
import 'package:bg_remover_fltuter/views/image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Remove Background',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ApiProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: provider.removeBackground,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 24.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlue],
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.upload_file,
                            color: Colors.white,
                            size: 28.0,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Upload Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (provider.isLoading) ...[
                    SizedBox(height: size.height * 0.04),
                    CircularProgressIndicator(color: Colors.blue),
                  ],

                  if (provider.imagePath != null) ...[
                    const SizedBox(height: 70),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildImageContainer(
                            provider,
                            size,
                            Image.file(
                              File(provider.pickedFile!),
                              width: size.width * 0.85,
                              fit: BoxFit.cover,
                            ),
                            'Before',
                            context,
                            provider.pickedFile!,
                          ),
                          _buildImageContainer(
                            provider,
                            size,
                            Image.memory(
                              provider.imagePath!,
                              width: size.width * 0.85,
                              fit: BoxFit.cover,
                            ),
                            'After',
                            context,
                            provider.imagePath!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildImageContainer(
  ApiProvider provider,
  Size size,
  Widget image,
  String text,
  BuildContext context,
  dynamic imagePath,
) {
  return Column(
    children: [
      GestureDetector(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageView(image: imagePath),
              ),
            ),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: image,
        ),
      ),
      SizedBox(height: size.height * 0.03),
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    ],
  );
}
