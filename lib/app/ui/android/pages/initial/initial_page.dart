import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/auth/sign_in_page.dart';
import 'package:konsi_app/app/ui/android/pages/home/home_page.dart';
import 'package:konsi_app/app/utils/constants.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    loggedUser = auth.currentUser;

    super.initState();
  }

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
          nextScreen:
              loggedUser?.email != null ? const HomePage() : const SigninPage(),
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
