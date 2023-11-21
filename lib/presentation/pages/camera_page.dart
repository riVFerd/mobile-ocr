import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/action_button.dart';
import 'pick_image.dart';

@Deprecated('Use [PickImagePage] instead for better performance')
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  static const routeName = '/cameraPage';

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;
  late ImagePicker imagePicker;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras.first, ResolutionPreset.max);
    imagePicker = ImagePicker();
    await cameraController.initialize();
  }

  IconData getFlashIcon() {
    FlashMode flashMode = cameraController.value.flashMode;
    switch (flashMode) {
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.torch:
        return Icons.flashlight_on;
    }
  }

  Future<void> toggleFlash() async {
    FlashMode flashMode = cameraController.value.flashMode;
    switch (flashMode) {
      case FlashMode.always:
        await cameraController.setFlashMode(FlashMode.off);
        break;
      case FlashMode.off:
        await cameraController.setFlashMode(FlashMode.auto);
        break;
      case FlashMode.auto:
        await cameraController.setFlashMode(FlashMode.torch);
        break;
      case FlashMode.torch:
        await cameraController.setFlashMode(FlashMode.always);
        break;
    }
  }

  void takePicture() async {
    final imageFile = await cameraController.takePicture();
    cameraController.setFlashMode(FlashMode.off);
    setState(() {});
    Navigator.of(context).pushNamed(
      PickImagePage.routeName,
      arguments: imageFile.path,
    );
  }

  void browseGallery() async {
    final imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      Navigator.of(context).pushNamed(
        PickImagePage.routeName,
        arguments: imageFile.path,
      );
    }
  }

  @override
  void dispose() {
    cameraController.stopImageStream();
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: initializeCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CameraPreview(
                        cameraController,
                      ),
                    ),
                    _CameraButtons(
                      onFlashToggle: toggleFlash,
                      onTakePicture: takePicture,
                      onBrowseGallery: browseGallery,
                      getFlashIcon: getFlashIcon,
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CameraButtons extends StatefulWidget {
  final Future<void> Function() onFlashToggle;
  final void Function() onTakePicture;
  final void Function() onBrowseGallery;
  final IconData Function() getFlashIcon;

  const _CameraButtons({
    required this.onFlashToggle,
    required this.onTakePicture,
    required this.onBrowseGallery,
    required this.getFlashIcon,
  });

  @override
  State<_CameraButtons> createState() => _CameraButtonsState();
}

class _CameraButtonsState extends State<_CameraButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          onClick: () async {
            await widget.onFlashToggle();
            setState(() {});
          },
          iconSize: 24,
          iconData: widget.getFlashIcon(),
        ),
        ActionButton(
          onClick: widget.onTakePicture,
          iconSize: 46,
          iconData: Icons.camera_alt,
        ),
        ActionButton(
          onClick: widget.onBrowseGallery,
          iconSize: 24,
          iconData: Icons.photo_library,
        ),
      ],
    );
  }
}
