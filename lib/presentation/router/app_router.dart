import 'package:flutter/material.dart';

import '../pages/camera_page.dart';
import '../pages/home_page.dart';
import '../pages/image_preview_page.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case CameraPage.routeName:
        return MaterialPageRoute(builder: (_) => const CameraPage());
      case ImagePreviewPage.routeName:
        final imagePath = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ImagePreviewPage(imagePath: imagePath));
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
