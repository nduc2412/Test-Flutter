import 'dart:async';

import 'package:duckyapp/common/login_sign_up_widgets/login_sign_up_button.dart';
import 'package:duckyapp/domain/entities/user_entity.dart';
import 'package:duckyapp/presentation/bloc/states.dart';
import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/image.dart';
import 'package:duckyapp/utils/const/size/NImageSize.dart';
import 'package:duckyapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/const/note_space.dart';
import '../../../utils/const/note_text.dart';
import '../../../utils/const/size/text_size.dart';
import '../../bloc/bloc.dart';
import '../../bloc/events.dart';

class EmailVerifyWaitingView extends StatefulWidget {
  const EmailVerifyWaitingView({super.key});

  @override
  State<EmailVerifyWaitingView> createState() => _EmailVerifyWaitingViewState();
}

class _EmailVerifyWaitingViewState extends State<EmailVerifyWaitingView> {
  late final Timer _timer;
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(SendEmailVerifyEvent());
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      context.read<AuthBloc>().add(EmailVerifyCheckReloadEvent());
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute
        .of(context)!
        .settings
        .arguments as AuthUserEntity;
    return BlocListener<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is EmailVerifySuccessActionState) {
          Navigator.pushReplacementNamed(context, Routes.verifyEmailSuccess, arguments: user);
        }
      },
      child: Scaffold(
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
                user.email,
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
                  onPressed: () {
                    context.read<AuthBloc>().add(SendEmailVerifyEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
