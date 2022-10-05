import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:konsi_app/app/routes/routes.dart';

import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:konsi_app/app/ui/android/pages/auth/sign_in_page.dart';
import 'package:konsi_app/app/ui/android/pages/home/home_page.dart';

import 'package:page_transition/page_transition.dart' show PageTransitionType;
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  User? loggedUser;

 // GoogleSignInAccount? loggedUserGoogle;
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
   // GoogleSignIn googleSignIn = GoogleSignIn();
    loggedUser = auth.currentUser;
    //loggedUserGoogle = googleSignIn.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetSizeConfig().init(context);
    // List teste = [loggedUser, loggedUserGoogle];
    // Widget? _CheckPage() {
    //   if (loggedUser?.email == null) {
    //     Navigator.of(context).pushReplacementNamed(Routes.login);
    //   } else if (loggedUserGoogle?.email == null) {
    //     Navigator.of(context).pushReplacementNamed(Routes.login);
    //   } else if (loggedUser?.email != null) {
    //     Navigator.of(context).pushReplacementNamed(Routes.home);
    //   } else if (loggedUserGoogle?.email != null) {
    //     Navigator.of(context).pushReplacementNamed(Routes.home);
    //   } else {
    //     return ListView(children: [Text(teste.toString())]);
    //   }
    // }

    return Stack(
      children: [
        AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/logo-konsi.png',
            fit: BoxFit.contain,
            width: WidgetSizeConfig.safeBlockHorizontal! * 60,
          ),
          nextScreen:



          loggedUser?.email != null
              ? const HomePage()
              : const SigninPage(),
                //  ? const HomePage()
                  // : loggedUser?.email != null
                  //     ? const HomePage()
                  //     : loggedUser?.email != null
                  //         ? const HomePage()
                  //         : const SigninPage(),



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
