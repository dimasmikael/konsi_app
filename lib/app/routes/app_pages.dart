import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:konsi_app/app/routes/app_routes.dart';
import 'package:konsi_app/app/ui/android/pages/login/login_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const LoginPage(),
    )
  ];
}
