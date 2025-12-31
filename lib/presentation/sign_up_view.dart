import 'package:duckyapp/common/login_sign_up_widgets/email_text_field.dart';
import 'package:duckyapp/common/login_sign_up_widgets/footer_social_options.dart';
import 'package:duckyapp/common/login_sign_up_widgets/form_divider.dart';
import 'package:duckyapp/common/login_sign_up_widgets/login_sign_up_button.dart';
import 'package:duckyapp/common/login_sign_up_widgets/password_text_field.dart';
import 'package:duckyapp/utils/const/size/button_size.dart';
import 'package:duckyapp/utils/const/field_radius.dart';
import 'package:duckyapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';

import '../utils/const/font_weight.dart';
import '../utils/const/note_space.dart';
import '../utils/const/note_text.dart';
import '../utils/const/size/text_size.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          padding: EdgeInsetsGeometry.symmetric(
            vertical: NSpace.paddingScreenSpaceVertical,
            horizontal: NSpace.paddingScreenSpaceHorizontal,
          ),
          child: Column(
            children: [
              // ************** Header ******************
              SizedBox(height: NSpace.spaceBtwTitle),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    NText.signUpTitle,
                    style: TextStyle(
                      fontWeight: NFontWeight.titleFontWeight,
                      fontSize: NTextSize.titleFontSize,
                    ),
                  ),
                ],
              ),
              // ************** Form ******************
              SizedBox(height: NSpace.spaceBtwHeaderForm),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Real name text fields
                    Row(
                      children: [
                        // First name text field
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(
                              fontWeight: NFontWeight.boldFontWeight,
                            ),
                            decoration: InputDecoration(
                              labelText: NText.firstName,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  NFieldRadius.textFieldRadius,
                                ),
                              ),
                              labelStyle: TextStyle(
                                fontWeight: NFontWeight.boldFontWeight,
                              ),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        // Last name text field
                        SizedBox(width: NSpace.spaceBtwItems / 2),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(
                              fontWeight: NFontWeight.boldFontWeight,
                            ),
                            decoration: InputDecoration(
                              labelText: NText.lastName,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  NFieldRadius.textFieldRadius,
                                ),
                              ),
                              labelStyle: TextStyle(
                                fontWeight: NFontWeight.boldFontWeight,
                              ),
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // User name text field
                    SizedBox(height: NSpace.spaceBtwTextField),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: NText.userName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            NFieldRadius.textFieldRadius,
                          ),
                        ),
                        prefixIcon: Icon(Icons.person),
                        labelStyle: TextStyle(
                          fontWeight: NFontWeight.boldFontWeight,
                        ),
                      ),
                      style: TextStyle(fontWeight: NFontWeight.boldFontWeight),
                    ),

                    // Email text field
                    SizedBox(height: NSpace.spaceBtwTextField),
                    EmailTextField(),

                    // Phone number text field
                    SizedBox(height: NSpace.spaceBtwTextField),
                    TextFormField(
                      style: TextStyle(fontWeight: NFontWeight.boldFontWeight),
                      decoration: InputDecoration(
                        labelText: NText.phoneNumber,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            NFieldRadius.textFieldRadius,
                          ),
                        ),
                        prefixIcon: Icon(Icons.phone),
                        labelStyle: TextStyle(
                          fontWeight: NFontWeight.boldFontWeight,
                        ),
                      ),
                    ),

                    // Password text field
                    SizedBox(height: NSpace.spaceBtwTextField),
                    PasswordTextField(obscureText: _obscureText),

                    // Sign up button
                    SizedBox(height: NSpace.spaceBtwItems),
                    SizedBox(
                      height: NButtonSize.buttonHeight,
                      width: double.infinity,
                      child: MainButton(
                        displayText: NText.signUp,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, Routes.verifyEmail, (route) => false, arguments: "23@gmail.com");
                        },
                      ),
                    ),

                    // Agree with terms and policy
                    SizedBox(height: NSpace.spaceBtwItems / 2),
                    FormField<bool>(
                      validator: (value) {
                        if (value == false) {
                          return NText.noticeAgreePolicy;
                        }
                      },
                      builder: (state) =>
                          Row(
                            children: [
                              Checkbox(
                                value: state.value ?? false,
                                onChanged: (newValue) {
                                  state.didChange(newValue);
                                },
                              ),
                              Expanded(
                                child: Text(
                                  NText.agreeWithPolicy,
                                  style: TextStyle(
                                    fontWeight: NFontWeight.boldFontWeight,
                                    fontSize: NTextSize.normalFontSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),

                    // Divider
                    SizedBox(height: NSpace.spaceBtwItems / 2),
                    FormDivider(displayText: NText.orContinueWith),

                    // Social options
                    SizedBox(height: NSpace.spaceBtwItems / 2),
                    FooterSocialOptions(),

                    // Already have an account text
                    SizedBox(height: NSpace.spaceBtwItems / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          NText.alreadyHaveAccount,
                          style: TextStyle(
                            fontWeight: NFontWeight.boldFontWeight,
                            fontSize: NTextSize.normalFontSize,
                          ),
                        ),
                        SizedBox(width: NSpace.textFieldContentPadding / 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
                          },
                          child: Text(
                            NText.login,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
