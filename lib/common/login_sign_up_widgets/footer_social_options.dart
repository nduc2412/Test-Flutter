import 'package:flutter/material.dart';

import '../../utils/const/color.dart';
import '../../utils/const/size/button_size.dart';
import '../../utils/const/image.dart';
import '../../utils/const/note_space.dart';


class FooterSocialOptions extends StatelessWidget {
  const FooterSocialOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          width: NButtonSize.socialButtonSize,
          height: NButtonSize.socialButtonSize,
          child: IconButton(
            onPressed: () {},
            icon: Image(image: AssetImage(NImage.google)),
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                  ) {
                if (states.contains(WidgetState.pressed)) {
                  return NColors.whiteOnPressed;
                } else {
                  return NColors.white;
                }
              }),
            ),
          ),
        ),
        SizedBox(width: NSpace.spaceBtwItems / 2),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          width: NButtonSize.socialButtonSize,
          height: NButtonSize.socialButtonSize,
          child: IconButton(
            onPressed: () {},
            icon: Image(image: AssetImage(NImage.facebook)),
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                  ) {
                if (states.contains(WidgetState.pressed)) {
                  return NColors.whiteOnPressed;
                } else {
                  return NColors.white;
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}