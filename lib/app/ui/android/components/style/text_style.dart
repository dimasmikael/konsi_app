import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/components/widget_size_configuration/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

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

Widget textAlert(String texto) {
  return Text(
    texto,
    maxLines: 5,
    style: TextStyle(
      fontSize: WidgetSizeConfig.safeBlockHorizontal! * 3.5,
    ),
  );
}

Widget textAppBar(String text) {
  return Align(
    alignment: Alignment.center,
    child: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: WidgetSizeConfig.safeBlockHorizontal! * 6,
      ),
    ),
  );
}
