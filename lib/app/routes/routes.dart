import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/pages/auth/register_page.dart';
import 'package:konsi_app/app/ui/android/pages/auth/sign_in_page.dart';
import 'package:konsi_app/app/ui/android/pages/home/home_page.dart';
import 'package:konsi_app/app/ui/android/pages/initial/initial_page.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';


  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const InitialPage(),
    login: (BuildContext context) => const SigninPage(),
    register: (BuildContext context) => const RegistrationPage(),
    home: (BuildContext context) => const HomePage(),

  };
}
