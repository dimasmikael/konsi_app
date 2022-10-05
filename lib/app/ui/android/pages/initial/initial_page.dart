import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:konsi_app/app/data/providers/auth_provider.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/auth/sign_in_page.dart';
import 'package:konsi_app/app/ui/android/pages/home/home_page.dart';

import 'package:page_transition/page_transition.dart' show PageTransitionType;
import 'package:provider/provider.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    final authProvider = Provider.of<AuthProvider>(context);

    // print("authProvider.signOut(context)");
    // print(authProvider.signOut(context));
    // print("authProvider.signOutGoogle(context)");
    // print(authProvider.signInWithGoogle(context: context));
    return Stack(
      children: [
        AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/logo-konsi.png',
            fit: BoxFit.contain,
            width: WidgetSizeConfig.safeBlockHorizontal! * 60,
          ),
           nextScreen:
          authProvider.checkLoggedUser() == null ||
                  authProvider.checkLoggedUserGoogle() == null?
         const SigninPage()
            : const HomePage(),
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
