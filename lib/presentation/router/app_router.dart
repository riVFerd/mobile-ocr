import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/pick_image.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case PickImagePage.routeName:
        return MaterialPageRoute(builder: (_) => const PickImagePage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
