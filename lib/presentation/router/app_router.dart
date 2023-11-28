import 'package:flutter/material.dart';
import 'package:mobile_ocr/presentation/pages/review_page.dart';

import '../../logic/models/KTP.dart';
import '../pages/home_page.dart';
import '../pages/pick_image_page.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case PickImagePage.routeName:
        return MaterialPageRoute(builder: (_) => const PickImagePage());
      case ReviewPage.routeName:
        final ktp = settings.arguments as KTP;
        return MaterialPageRoute(builder: (_) => ReviewPage(ktp: ktp));
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
