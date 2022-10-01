import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/global_widgets/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/login/login_page.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    return Stack(
      children: [
        AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/logo-konsi.png',
            fit: BoxFit.contain,
            width: WidgetSizeConfig.safeBlockHorizontal! * 60,
          ),
          nextScreen: const LoginPage(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          backgroundColor: Colors.white,
          duration: 5000,
          splashIconSize: 300,
        ),
      ],
    );
  }
}
