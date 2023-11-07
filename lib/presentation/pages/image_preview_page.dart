import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_ocr/presentation/pages/home_page.dart';

class ImagePreviewPage extends StatelessWidget {
  final String imagePath;

  const ImagePreviewPage({super.key, required this.imagePath});

  static const routeName = '/imagePreview';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.file(File(imagePath)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
