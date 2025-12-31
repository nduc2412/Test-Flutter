import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/image.dart';
import 'package:duckyapp/utils/const/note_space.dart';
import 'package:duckyapp/utils/const/note_text.dart';
import 'package:duckyapp/utils/const/size/NImageSize.dart';
import 'package:duckyapp/utils/const/size/text_size.dart';
import 'package:flutter/material.dart';

import '../common/login_sign_up_widgets/login_sign_up_button.dart';

class EmailVerifySuccess extends StatelessWidget {
  const EmailVerifySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: NSpace.paddingScreenSpaceVertical,
          horizontal: NSpace.paddingScreenSpaceHorizontal,
        ),
        child: Column(
          children: [
            // Logo
            Image(
              image: AssetImage(NImage.emailVerifySuccessImage),
              height: NImageSize.logoHeight * 2,
            ),

            // Title
            SizedBox(height: NSpace.spaceBtwTitleLogo),
            Text(
              NText.accountCreated,
              style: TextStyle(
                fontWeight: NFontWeight.titleFontWeight,
                fontSize: NTextSize.titleFontSize,
              ),
            ),

            // Description
            Text(
              NText.accountCreatedDescription,
              style: TextStyle(
                fontWeight: NFontWeight.blurFontWeight,
                fontSize: NTextSize.normalFontSize,
              ),
            ),

            // Continue button
            MainButton(
              displayText: NText.continueText,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
