import 'package:flutter/material.dart';
import '../../utils/const/field_radius.dart';
import '../../utils/const/note_space.dart';
import '../../utils/const/note_text.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (password) {
        if (password == null || password.isEmpty) {
          return NText.passwordCannotEmpty;
        }

        if (password.length < 6) {
          return NText.passwordLength;
        }

        final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
        final hasNumber = RegExp(r'[0-9]').hasMatch(password);

        if (!hasLetter || !hasNumber) {
          return NText.passwordMustContainLetterAndNumber;
        }

        return null; // hợp lệ
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: GestureDetector(
          child: _obscureText ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(NRadius.textFieldRadius),
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
