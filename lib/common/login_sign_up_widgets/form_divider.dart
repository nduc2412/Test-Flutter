import 'package:flutter/material.dart';
import '../../utils/const/note_space.dart';
class FormDivider extends StatelessWidget {
  final String displayText;
  const FormDivider({
    super.key,
    required this.displayText
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: NSpace.paddingScreenSpaceHorizontal,
          ),
        ),
        Text(
          displayText,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Divider(color: Colors.grey,
              thickness: 1,
              indent: NSpace.paddingScreenSpaceHorizontal),
        ),
      ],
    );
  }
}
