import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:konsi_app/app/data/models/user_model.dart';


class LoginApiClient {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // GetStorage box = GetStorage('login_firebase');

  // Retorna usuário logado
  User? get onAuthStateChanged => _firebaseAuth.currentUser;

  // // Criar usuário
  Future createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
          email: email, password: password);
      //     .then(
      //       (firebaseUser) {
      //     Navigator.pushReplacementNamed(context!, '/homeview');
      //   },
      // );

    //  alert.success(context!, 'Login cadastrado com sucesso');
    } on FirebaseAuthException catch (error) {
      print(error);
      // alert.error(
      //   context!,
      //   error.toString(),
      // );
    } catch (e) {
      // print(e);
      // alert.error(
      //   context!,
      //   e.toString(),
      // );
    }
  }
  //
  //
  // // Fazer Login
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
          email: email, password: password);
      //     .then(
      //       (firebaseUser) {
      //     Navigator.pushReplacementNamed(context!, '/homeview');
      //   },
      // );

    //  alert.success(context!, 'Sucesso!');
    } on FirebaseAuthException catch (error) {
      print(error);
      // alert.error(
      //   context!,
      //   error.toString(),
      // );
    } catch (e) {
      print(e);
      // alert.error(
      //   context!,
      //   e.toString(),
      // );
    }
  }
  //
  //
  // // Fazer Logoff
  signOut(){
   // box.write("auth", null);
    //box.erase();
    return _firebaseAuth.signOut();
  }


}
