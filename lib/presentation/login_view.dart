import "dart:ui";

import "package:duckyapp/utils/const/button_color.dart";
import "package:duckyapp/utils/const/button_size.dart";
import "package:duckyapp/utils/const/field_radius.dart";
import "package:duckyapp/utils/const/font_weight.dart";
import "package:duckyapp/utils/const/image.dart";
import "package:duckyapp/utils/const/note_text.dart";
import "package:duckyapp/utils/const/text_size.dart";
import "package:duckyapp/utils/routes/routes.dart";
import "package:flutter/material.dart";

import "../common/footer_social_options.dart";
import "../common/form_divider.dart";
import "../utils/const/note_space.dart";
import "customized_widgets.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: NSpace.paddingScreenSpaceVertical,
            horizontal: NSpace.paddingScreenSpaceHorizontal,
          ),
          child: Column(
            children: [
              // *************** Logo, title and subtitle ********************
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  NImage.noteLogo,
                  SizedBox(height: NSpace.spaceBtwTitleLogo),
                  // Title and subtitle
                  Text(
                    NText.loginTitle,
                    style: TextStyle(
                      fontWeight: NTextWeight.titleFontWeight,
                      fontSize: NTextSize.titleFontSize,
                    ),
                  ),
                  SizedBox(height: NSpace.spaceBtwTitleSubTit),
                  Text(
                    NText.loginSubtitle,
                    style: TextStyle(
                      fontSize: NTextSize.subTitleFontSize,
                      fontWeight: NTextWeight.subTitleFontWeight,
                    ),
                  ),
                ],
              ),

              // **************** Form ********************
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email text field
                    TextFormField(
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
                    ),
                    // Password text field
                    SizedBox(height: NSpace.spaceBtwTextField),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: Icon(Icons.visibility),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            NFieldRadius.textFieldRadius,
                          ),
                        ),
                        labelText: NText.passwordLabel,
                        labelStyle: TextStyle(fontWeight: FontWeight.w600),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: NSpace.textFieldContentPadding,
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500),
                      obscureText: _obscureText,
                    ),
                    // Remember me and forgot password
                    SizedBox(height: NSpace.spaceBtwTextField / 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember me check box
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) => {
                                setState(() {
                                  _rememberMe = value!;
                                }),
                              },
                            ),
                            Text(
                              NText.rememberMe,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        // Forgot password
                        TextButton(
                          child: Text(NText.forgotPassword),
                          onPressed: () => {},
                        ),
                      ],
                    ),

                    // Login button
                    SizedBox(
                      height: NButtonSize.buttonHeight,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => {},
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
                          NText.login,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Sign up button
                    SizedBox(height: NSpace.spaceBtwItems / 2),
                    SizedBox(
                      height: NButtonSize.buttonHeight,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signUp);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color?>((
                                Set<WidgetState> states,
                              ) {
                                if (states.contains(WidgetState.pressed)) {
                                  return ButtonColors.whiteOnPressed;
                                } else {
                                  return ButtonColors.white;
                                }
                              }),
                        ),
                        child: Text(
                          NText.signUp,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ****************** Divider ********************
              SizedBox(height: NSpace.spaceBtwItems / 2),
              FormDivider(displayText: NText.orContinueWith),

              // ******************* Other social options ********************
              SizedBox(height: NSpace.spaceBtwItems / 2),
              FooterSocialOptions(),
            ],
          ),
        ),
      ),
    );
  }
}


void navigate() {}
