import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.onchanged, required this.hint, this.obscureText = false});
  String? hint;
  Function(String)? onchanged;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return "data is Empty";
          }
        },
        obscureText: obscureText!,
        onChanged: onchanged,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ));
  }
}
