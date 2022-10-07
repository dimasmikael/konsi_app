import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsi_app/app/data/providers/address_provider.dart';
import 'package:konsi_app/app/data/providers/auth_provider.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:konsi_app/app/ui/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    Container(color: Colors.greenAccent),
  );

  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider(),
            ),
            ChangeNotifierProvider<AddressProvider>(
              create: (context) => AddressProvider(),
            ),
          ],
          child: MaterialApp(
            theme: appThemeData,
            debugShowCheckedModeBanner: false,
            routes: Routes.routes,
            initialRoute: '/splash',
          ),
        ),
      );
    },
  );
}
