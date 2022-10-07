import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:konsi_app/app/ui/android/components/alerts/alert.dart';
import 'package:konsi_app/app/ui/android/components/loading/loading_widget.dart';

FirebaseAuth auth = FirebaseAuth.instance;
var db = FirebaseFirestore.instance;
GoogleSignIn googleSignIn = GoogleSignIn();
Alert alert = Alert();
User? loggedUser;
GoogleSignInAccount? loggedUserGoogle;
bool mounted = false;
LoadingWidget loadingWidget = LoadingWidget();

extension EmailValidator on dynamic {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
