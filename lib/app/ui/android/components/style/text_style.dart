import 'package:flutter/material.dart';

Widget textFormSignIn(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10,right: 10,top: 60),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(.7),
      ),
    ),
  );
}


Widget textGoogle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10,right: 10,top: 60),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
       // fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(.7),
      ),
    ),
  );
}