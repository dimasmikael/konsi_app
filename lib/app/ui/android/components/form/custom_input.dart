import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? helperText;
  final String? label;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final TextStyle? labelStyle;
  final Key? key;
  final Widget? suffixIcon;

  final IconData? icon;
   bool obscureText = false;

  CustomInputForm(
      {this.controller,
      this.hint,
      this.helperText,
      this.label,
      this.keyboardType,
      this.onSaved,
      this.maxLines,
      this.minLines,
      this.inputFormatters,
      this.validator,
      this.labelStyle,
      this.key,
      this.onChanged,
      this.onFieldSubmitted,
      this.icon,required this.obscureText,this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
      child:

      TextFormField(
        // onFieldSubmitted: onChanged,
        // key: this.key,
        // validator: this.validator,
        // inputFormatters: this.inputFormatters,
        // maxLines: this.maxLines,
        // minLines: this.minLines,
        // textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        // controller: this.controller,
        keyboardType: keyboardType,
        // onSaved: this.onSaved,
        // onChanged: this.onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          suffixIcon: suffixIcon,

          //  helperText:helperText,

          hintText: hint,
          labelText: label,
          //  labelStyle: this.labelStyle,
          // fillColor: Colors.white,
          // filled: true,
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
