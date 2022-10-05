import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/data/repository/login_repository.dart';
import 'package:konsi_app/app/routes/app_routes.dart';


class LoginController extends GetxController {
  final LoginRepository repository = LoginRepository();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  // GetStorage box = GetStorage('login_firebase');


  @override
  void onReady() {
//    isLogged();
    super.onReady();
  }

  // void isLogged(){
  //   if(box.hasData("auth")){
  //     UserModel user = UserModel(
  //       id: box.read("auth")["id"],
  //       email: box.read("auth")["email"],
  //       name: box.read("auth")["name"],
  //
  //     );
  //     Get.offAllNamed(Routes.HOME, arguments: user);
  //   }
  // }

  void register(UserModel user) async {
    // UserModel userModel = UserModel ();
    // userModel.email=  emailTextController.text;
    // userModel.password=   passwordTextController.text;
    Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
    User user = await repository.createUserWithEmailAndPassword(
      emailTextController.text,
        passwordTextController.text,
        );

    if (user != null) {
     // box.write("auth", user);
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }

  void login() async {
    Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
    User user = await repository.signInWithEmailAndPassword(
        emailTextController.text, passwordTextController.text);

    if(user != null){
   //   box.write("auth", user);
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }

  // void logout(){
  //   repository.signOut();
  //   Get.offAllNamed(Routes.LOGIN);
  // }
  
}
