import 'package:flutter/material.dart';
import '../utils/const/field_radius.dart';
import '../utils/const/note_space.dart';
import '../utils/const/note_text.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required bool obscureText,
  }) : _obscureText = obscureText;

  final bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: Icon(Icons.visibility),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            NFieldRadius.textFieldRadius,
          ),
        ),
        labelText: NText.passwordLabel,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        contentPadding: EdgeInsets.symmetric(
          vertical: NSpace.textFieldContentPadding,
        ),
      ),
      style: TextStyle(fontWeight: FontWeight.w500),
      obscureText: _obscureText,
    );
  }
}