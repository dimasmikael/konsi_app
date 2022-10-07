import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.text,
      required this.onPressed,
      this.icon,
      required this.color})
      : super(key: key);

  final double width;
  final double height;
  final void Function() onPressed;
  final String text;
  final Icon? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
