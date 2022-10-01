import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:konsi_app/app/routes/app_pages.dart';
import 'package:konsi_app/app/routes/app_routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: Routes.INITIAL,
    ),
  );
}
