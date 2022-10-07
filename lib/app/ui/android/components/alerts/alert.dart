import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/components/style/text_style.dart';

class Alert {
  void error(BuildContext context, String text, [TextStyle? textStyle]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 125,
            right: 20,
            left: 20),
        content: textAlert(text),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: "",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  void success(BuildContext context, String text, [TextStyle? textStyle]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 125,
            right: 20,
            left: 20),
        content: textAlert(
          text,
        ),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: "",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
