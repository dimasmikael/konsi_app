import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:konsi_app/app/ui/android/components/alerts/alert.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Alert _alert = Alert();
  User? loggedUser;

  checkLoggedUser() {
    loggedUser = _auth.currentUser;
    return loggedUser;
  }

  Future registerWithEmailAndPassword(
      UserModel? user, BuildContext? context) async {
    try {
      notifyListeners();
      _auth
          .createUserWithEmailAndPassword(
              email: user!.email, password: user.password)
          .then(
        (firebaseUser) {
          Navigator.pushReplacementNamed(context!, Routes.home);
        },
      );
      _alert.success(context!, 'Login cadastrado com sucesso');
    } on FirebaseAuthException catch (error) {
      print(error);
      notifyListeners();
      _alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      notifyListeners();
      print(e);
      _alert.error(
        context!,
        e.toString(),
      );
    }
    return null;
  }

  Future signInWithEmailAndPassword(
      UserModel? user, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: user!.email, password: user!.password)
          .then(
        (firebaseUser) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
      );
      notifyListeners();

      _alert.success(context!, 'Sucesso!');
    } on FirebaseAuthException catch (error) {
      notifyListeners();
      print(error);
      _alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      notifyListeners();
      print(e);
      _alert.error(
        context!,
        e.toString(),
      );
    }
    return null;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut(BuildContext context, [bool mounted = true]) async {
    try {
      await _auth.signOut().then(
        (firebaseUser) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.login, (Route<dynamic> route) => false);
        },
      );
      notifyListeners();
      if (!mounted) return;
      _alert.success(context, 'Deslogado com sucesso');
    } on FirebaseAuthException catch (error) {
      notifyListeners();
      print(error);
      _alert.error(
        context,
        error.toString(),
      );
    } catch (e) {
      notifyListeners();
      print(e);
      _alert.error(
        context,
        e.toString(),
      );
    }
  }
}
