import 'package:flutter/material.dart';

import '../pages/camera_page.dart';
import '../pages/home_page.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case CameraPage.routeName:
        return MaterialPageRoute(builder: (_) => const CameraPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
