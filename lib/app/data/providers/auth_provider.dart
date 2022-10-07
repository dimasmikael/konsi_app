import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:konsi_app/app/utils/constants.dart';

class AuthProvider extends ChangeNotifier {
  Future registerWithEmailAndPassword(
      UserModel? user, BuildContext? context) async {
    try {
      notifyListeners();
      auth
          .createUserWithEmailAndPassword(
              email: user!.email.toString().trim(),
              password: user.password.toString().trim())
          .then(
        (firebaseUser) {
          Navigator.pushReplacementNamed(context!, Routes.home);
        },
      );
    } on FirebaseAuthException catch (error) {
      print(error);
      notifyListeners();
      alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      notifyListeners();
      print(e);
      alert.error(
        context!,
        e.toString(),
      );
    }
    return null;
  }

  Future signInWithEmailAndPassword(
      UserModel? user, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: user!.email, password: user!.password)
          .then(
        (firebaseUser) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
      );
      notifyListeners();

      alert.success(context!, 'Sucesso!');
    } on FirebaseAuthException catch (error) {
      notifyListeners();
      print(error);
      alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      notifyListeners();
      print(e);
      alert.error(
        context!,
        e.toString(),
      );
    }
    return null;
  }

  Future signOut(BuildContext context, [bool mounted = true]) async {
    try {
      await auth.signOut().then(
        (firebaseUser) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.login, (Route<dynamic> route) => false);
        },
      );
      notifyListeners();
      if (!mounted) return;
      alert.success(context, 'Deslogado com sucesso');
    } on FirebaseAuthException catch (error) {
      notifyListeners();
      print(error);
      alert.error(
        context,
        error.toString(),
      );
    } catch (e) {
      notifyListeners();
      print(e);
      alert.error(
        context,
        e.toString(),
      );
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
        notifyListeners();
      } catch (e) {
        print(e);
        notifyListeners();
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        notifyListeners();
        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
          notifyListeners();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            if (!mounted) {}
            alert.error(
              context,
              'The account already exists with a different credential',
            );
            notifyListeners();
          } else if (e.code == 'invalid-credential') {
            if (!mounted) {}
            alert.error(
              context,
              'Error occurred while accessing credentials. Try again.',
            );
            notifyListeners();
          }
        } catch (e) {
          if (!mounted) {}
          alert.error(
            context,
            'Error occurred using Google Sign In. Try again.',
          );
        }
        notifyListeners();
      }
    }

    return user;
  }

  Future<void> signOutGoogle({required BuildContext context}) async {
    try {
      await googleSignIn.signOut().then((google) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.login, (Route<dynamic> route) => false);
      });
      notifyListeners();
    } catch (e) {
      alert.error(
        context,
        'Error signing out. Try again.',
      );
      notifyListeners();
    }
  }
}
