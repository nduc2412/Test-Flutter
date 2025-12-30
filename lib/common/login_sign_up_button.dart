import 'package:flutter/material.dart';

import '../utils/const/button_color.dart';
class MainButton extends StatelessWidget {
  final String displayText;
  final void Function()? onPressed;
  const MainButton({
    super.key,
    required this.displayText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
        WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
            ) {
          if (states.contains(WidgetState.pressed)) {
            return ButtonColors.blackOnPressed;
          } else {
            return ButtonColors.black;
          }
        }),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}