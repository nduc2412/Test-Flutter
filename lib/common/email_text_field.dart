import 'package:flutter/material.dart';

import '../utils/const/field_radius.dart';
import '../utils/const/note_space.dart';
import '../utils/const/note_text.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            NFieldRadius.textFieldRadius,
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
