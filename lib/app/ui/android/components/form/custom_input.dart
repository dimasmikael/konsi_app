import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final IconData? icon;
  bool obscureText = false;

  CustomInputForm(
      {super.key,
      this.controller,
      this.hint,
      this.label,
      this.keyboardType,
      this.icon,
      required this.obscureText,
      this.suffixIcon,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: TextFormField(
        validator: validator,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          suffixIcon: suffixIcon,
          hintText: hint,
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
