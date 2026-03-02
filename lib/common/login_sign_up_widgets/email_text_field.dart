import 'package:flutter/material.dart';

import '../../utils/const/field_radius.dart';
import '../../utils/const/note_space.dart';
import '../../utils/const/note_text.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (email) {
          if (email == null || email.trim().isEmpty) {
            return NText.emailCannotEmpty;
          }
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
          if (!emailRegex.hasMatch(email.trim())) {
            return NText.invalidEmail;
          }
          return null; // hợp lệ

      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            NRadius.textFieldRadius,
          ),
        ),
        labelText: NText.emailLabel,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        contentPadding: EdgeInsets.symmetric(
          vertical: NSpace.textFieldContentPadding,
        ),
      ),
      style: TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
