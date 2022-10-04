import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:konsi_app/app/routes/app_routes.dart';
import 'package:konsi_app/app/ui/android/pages/home/home_page.dart';
import 'package:konsi_app/app/ui/android/pages/initial/initial_page.dart';
import 'package:konsi_app/app/ui/android/pages/login/login_page.dart';
import 'package:konsi_app/app/ui/android/pages/login/registration_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const InitialPage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.REGISTRATION,
      page: () => const RegistrationPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
    )
  ];
}
