import 'package:flutter/material.dart';

Widget textFormSignIn(String text) {
  return Text(
    text,

    style: const TextStyle(
      color: Colors.black,
      fontFamily: 'OpenSans',
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),

  );
}

Widget textGoogle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black.withOpacity(.7),
      ),
    ),
  );
}

Widget textLabelInput(String text) {
  return Padding(
    padding: const EdgeInsets.only(right: 250, top: 10),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
  );
}
