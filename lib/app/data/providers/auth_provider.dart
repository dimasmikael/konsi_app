import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:konsi_app/app/data/models/user_model.dart';
import 'package:konsi_app/app/routes/routes.dart';
import 'package:konsi_app/app/ui/android/components/alerts/alert.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Alert _alert = Alert();

  User? loggedUser;
  GoogleSignInAccount? loggedUserGoogle;
  bool mounted = false;

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
            _alert.error(
              context,
              'The account already exists with a different credential',
            );
            notifyListeners();
          } else if (e.code == 'invalid-credential') {
            if (!mounted) {}
            _alert.error(
              context,
              'Error occurred while accessing credentials. Try again.',
            );
            notifyListeners();
          }
        } catch (e) {
          if (!mounted) {}
          _alert.error(
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
      print(1);
      //   if (!kIsWeb) {
      await googleSignIn.signOut().then((google) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.login, (Route<dynamic> route) => false);
      });
      notifyListeners();
      // }
      //  await _auth.signOut();
      // await googleSignIn.signOut();
    } catch (e) {
      print(2);
      _alert.error(
        context,
        'Error signing out. Try again.',
      );
      notifyListeners();
    }
  }

  // checkLoggedUserGoogle() {
  //   loggedUserGoogle = googleSignIn.currentUser;
  //
  //   return loggedUserGoogle;
  // }
}
