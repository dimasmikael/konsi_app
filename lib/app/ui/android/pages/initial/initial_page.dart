import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/pages/login/login_page.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedSplashScreen(
        splash: Container(
         // color: Colors.blue,
          width: 200,
          child: Image.asset(
            'assets/images/logo-konsi.png',
            fit: BoxFit.contain,
          ),
        ),

        nextScreen: const LoginPage(),
        // loggedUser == null ? const LoginView() : const HomeView(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        backgroundColor: Colors.white,
        duration: 5000,
        splashIconSize: 300,
      ),
    ]);
  }
}
