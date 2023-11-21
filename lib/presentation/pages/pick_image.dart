import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_ocr/presentation/pages/home_page.dart';

import '../../logic/helper/connection.dart';
import '../widgets/action_button.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key});

  static const routeName = '/pickImagePage';

  @override
  State<PickImagePage> createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  ImagePicker imagePicker = ImagePicker();
  XFile? imageFile;

  final dio = Dio(
    BaseOptions(
      baseUrl: Platform.environment['SERVER_URL'] ?? 'http://localhost:5000',
    ),
  );

  Future<String> pingServer(Dio dio) async {
    String statusCode = '0';
    try {
      final response = await dio.get('/ping');
      statusCode = response.statusCode.toString();
    } on DioException catch (e) {
      statusCode = e.response!.statusCode.toString();
    }
    return statusCode;
  }

  Future<void> sendImage(Dio dio) async {
    final statusCode = await Connection(dio).uploadFile(imageFile!.path, '/ocr');
    if (statusCode == '200') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image sent successfully'),
        ),
      );
      Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
    }
  }

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage == null) return;
    imageFile = pickedImage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: (imageFile != null)
                  ? Center(
                      child: Image.file(
                        File(imageFile!.path),
                      ),
                    )
                  : const Center(
                      child: Text('No image selected'),
                    ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: (imageFile != null) ? () => sendImage(dio) : null,
                        child: const Text('Send Image'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final statusCode = await pingServer(dio);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Server responded with status code: $statusCode'),
                            ),
                          );
                        },
                        child: const Text('Ping Server'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
                        },
                        child: const Text('Home'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionButton(
                        onClick: () => pickImage(ImageSource.camera),
                        iconSize: 24,
                        iconData: Icons.camera_alt,
                      ),
                      ActionButton(
                        onClick: () => pickImage(ImageSource.gallery),
                        iconSize: 24,
                        iconData: Icons.photo_library,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
