import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'image_preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  static const routeName = '/cameraPage';

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras.first, ResolutionPreset.max);
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
      ImagePreviewPage.routeName,
      arguments: imageFile.path,
    );
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
                      onCameraSwitch: () {},
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
  final void Function() onCameraSwitch;
  final IconData Function() getFlashIcon;

  const _CameraButtons({
    required this.onFlashToggle,
    required this.onTakePicture,
    required this.onCameraSwitch,
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
          onClick: () async {
            // TODO: Implement camera switching
            // final cameras = await availableCameras();
            // if (cameras.length > 1) {
            //   if (cameraController.description == cameras.first) {
            //     cameraController.setDescription(cameras.first);
            //   } else {
            //     cameraController.setDescription(cameras.last);
            //   }
            // }
          },
          iconSize: 24,
          iconData: Icons.flip_camera_ios,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final void Function() onClick;
  final IconData iconData;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const ActionButton({
    super.key,
    required this.iconData,
    required this.onClick,
    required this.iconSize,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.hardEdge,
      elevation: 16,
      color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            iconData,
            color: iconColor ?? Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
