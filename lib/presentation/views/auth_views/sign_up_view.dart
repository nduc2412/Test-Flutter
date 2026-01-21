import 'package:duckyapp/common/login_sign_up_widgets/email_text_field.dart';
import 'package:duckyapp/common/login_sign_up_widgets/footer_social_options.dart';
import 'package:duckyapp/common/login_sign_up_widgets/form_divider.dart';
import 'package:duckyapp/common/login_sign_up_widgets/login_sign_up_button.dart';
import 'package:duckyapp/common/login_sign_up_widgets/password_text_field.dart';
import 'package:duckyapp/presentation/bloc/bloc.dart';
import 'package:duckyapp/utils/const/size/button_size.dart';
import 'package:duckyapp/utils/const/field_radius.dart';
import 'package:duckyapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/auth_use_cases/forgot_password_use_case.dart';
import '../../../domain/use_cases/auth_use_cases/login_use_case.dart';
import '../../../domain/use_cases/auth_use_cases/send_email_verification_use_case.dart';
import '../../../domain/use_cases/auth_use_cases/sign_out_use_case.dart';
import '../../../domain/use_cases/auth_use_cases/sign_up_use_case.dart';
import '../../../injections.dart';
import '../../../utils/const/font_weight.dart';
import '../../../utils/const/note_space.dart';
import '../../../utils/const/note_text.dart';
import '../../../utils/const/size/text_size.dart';
import '../../bloc/events.dart';
import '../../bloc/states.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.runtimeType == SignUpSuccessActionState) {
          context.read<AuthBloc>().add(SendEmailVerifyEvent());
        } else if (state.runtimeType == EmailVerifyingWaitingActionState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.verifyEmailWaiting,
            (route) => false,
            arguments: _emailController.text,
          );
        } else if (state.runtimeType == UserNotFoundState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text("UserNotFound")),
          );
        } else if (state.runtimeType == UserAlreadyExistsState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text("user exists")),
          );
        } else if (state.runtimeType == WeakPasswordState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text("weak pass")),
          );
        } else if (state.runtimeType == GenericExceptionState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text("Generic errror")),
          );
        }
      },
      builder: (context, state) {
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
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return NText.firstNameRequired;
                                  }
                                  if (!RegExp(
                                    r"^[a-zA-ZÀ-ỹ\s'-]+$",
                                  ).hasMatch(value.trim())) {
                                    return NText.firstNameInvalid;
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontWeight: NFontWeight.boldFontWeight,
                                ),
                                decoration: InputDecoration(
                                  labelText: NText.firstName,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      NRadius.textFieldRadius,
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
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return NText.lastNameRequired;
                                  }
                                  if (!RegExp(
                                    r"^[a-zA-ZÀ-ỹ\s'-]+$",
                                  ).hasMatch(value.trim())) {
                                    return NText.lastNameInvalid;
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontWeight: NFontWeight.boldFontWeight,
                                ),
                                decoration: InputDecoration(
                                  labelText: NText.lastName,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      NRadius.textFieldRadius,
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty)
                              return NText.userNameRequired;
                            if (value.length < 4)
                              return NText.userNameNotEnough;
                            if (!RegExp(r"^[a-zA-Z0-9._]+$").hasMatch(value)) {
                              return NText.userNameInvalid;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: NText.userName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                NRadius.textFieldRadius,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person),
                            labelStyle: TextStyle(
                              fontWeight: NFontWeight.boldFontWeight,
                            ),
                          ),
                          style: TextStyle(
                            fontWeight: NFontWeight.boldFontWeight,
                          ),
                        ),

                        // Email text field
                        SizedBox(height: NSpace.spaceBtwTextField),
                        EmailTextField(),

                        // Phone number text field
                        SizedBox(height: NSpace.spaceBtwTextField),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty)
                              return NText.phoneNumberRequired;
                            final phone = value.replaceAll(' ', '');
                            if (!RegExp(r"^[0-9]{9,11}$").hasMatch(phone)) {
                              return NText.phoneNumberInvalid;
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontWeight: NFontWeight.boldFontWeight,
                          ),
                          decoration: InputDecoration(
                            labelText: NText.phoneNumber,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                NRadius.textFieldRadius,
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
                        PasswordTextField(),

                        // Sign up button
                        SizedBox(height: NSpace.spaceBtwItems),
                        SizedBox(
                          height: NButtonSize.buttonHeight,
                          width: double.infinity,
                          child: MainButton(
                            displayText: NText.signUp,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  SignUpButtonClickedEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }
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
                            return null;
                          },
                          builder: (state) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: state.value ?? false,
                                    onChanged: (newValue) {
                                      state.didChange(newValue);
                                    },
                                    side: state.hasError
                                        ? const BorderSide(color: Colors.red)
                                        : null,
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

                              if (state.hasError)
                                Text(
                                  state.errorText!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
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
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.login,
                                  (route) => false,
                                );
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
      },
    );
  }
}
