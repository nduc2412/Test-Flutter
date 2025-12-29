import 'package:flutter/material.dart';
class CircularTextField extends StatelessWidget {
  const CircularTextField({
    super.key,
    required this.controller,
    this.obscure = false,
    this.autoCorrect = false,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
  });

  final String? labelText;
  final  prefixIcon;
  final Icon? suffixIcon;
  final bool obscure;
  final TextEditingController controller;
  final bool autoCorrect;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        fillColor: Color.fromRGBO(243, 243, 247, 100),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

      ),
      obscureText: obscure,
      controller: controller,
      autocorrect: autoCorrect,
    );
  }
}
