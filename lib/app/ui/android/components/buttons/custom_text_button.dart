import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,

      required this.text,
      required this.onPressed,
      required this.icon,required this.foregroundColor})
      : super(key: key);


  final void Function()? onPressed;
  final String text;
  final Widget icon;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 50,
      child:

      TextButton.icon(
        label: Text(text),
        icon: icon,
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.greenAccent, width: 1),
          foregroundColor: foregroundColor,
          textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontStyle: FontStyle.italic
          ),
        ),
        onPressed: onPressed),);
  }
}
