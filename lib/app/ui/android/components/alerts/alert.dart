import 'package:flutter/material.dart';
import 'package:konsi_app/app/ui/android/components/style/text_style.dart';


class Alert {
  void error(BuildContext context, String text, [TextStyle? textStyle]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
