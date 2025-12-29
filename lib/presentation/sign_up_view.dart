import 'package:flutter/material.dart';

import '../utils/const/note_space.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: NSpace.paddingScreenSpaceVertical,
            horizontal: NSpace.paddingScreenSpaceHorizontal,
          ),
          child: Column(
            children: [
              // ************** Header ******************
              Column(
                children: [

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
