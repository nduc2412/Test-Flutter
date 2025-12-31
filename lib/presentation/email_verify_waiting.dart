import 'package:duckyapp/common/login_sign_up_widgets/login_sign_up_button.dart';
import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/image.dart';
import 'package:duckyapp/utils/const/size/NImageSize.dart';
import 'package:flutter/material.dart';

import '../utils/const/note_space.dart';
import '../utils/const/note_text.dart';
import '../utils/const/size/text_size.dart';

class EmailVerifyWaitingScreen extends StatelessWidget {
  const EmailVerifyWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: NSpace.paddingScreenSpaceHorizontal,
          vertical: NSpace.paddingScreenSpaceVertical,
        ),
        child: Column(
          children: [
            // Image
            Image(
              image: AssetImage(NImage.emailVerifyWaitingImage),
              height: NImageSize.logoHeight * 1.5,
            ),

            // Title
            SizedBox(height: NSpace.spaceBtwTitleLogo),
            Text(
              NText.verifyYourEmailAddress,
              style: TextStyle(
                fontWeight: NFontWeight.titleFontWeight,
                fontSize: NTextSize.titleFontSize,
              ),
            ),

            // Email address
            SizedBox(height: NSpace.spaceBtwTitleSubTit),
            Text(
              email,
              style: TextStyle(
                fontWeight: NFontWeight.boldFontWeight,
                fontSize: NTextSize.subTitleFontSize,
              ),
            ),

            // Description
            SizedBox(height: NSpace.spaceBtwItems / 2),
            Text(
              NText.verifyEmailDescription,
              style: TextStyle(
                fontWeight: NFontWeight.blurFontWeight,
                fontSize: NTextSize.normalFontSize,
              ),
              textAlign: TextAlign.center,
            ),

            // Resend email button
            SizedBox(height: NSpace.spaceBtwItems,),
            Text(
              NText.notReceiveEmail,
              style: TextStyle(
                fontWeight: NFontWeight.subTitleFontWeight,
                fontSize: NTextSize.normalFontSize,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: MainButton(
                displayText: NText.resendEmail,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
