import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:konsi_app/app/routes/app_pages.dart';
import 'package:konsi_app/app/routes/app_routes.dart';
import 'package:konsi_app/app/ui/theme/app_theme.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Flutter Demo',
      theme: appThemeData,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: Routes.REGISTRATION,
    ),
  );
}
