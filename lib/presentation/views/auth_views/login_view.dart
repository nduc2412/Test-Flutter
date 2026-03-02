import "dart:ui";
import "package:duckyapp/data/data_source/fire_base/auth_exceptions.dart";
import "package:duckyapp/presentation/bloc/bloc.dart";
import "package:duckyapp/presentation/bloc/states.dart";
import "package:duckyapp/utils/const/color.dart";
import "package:duckyapp/utils/const/size/button_size.dart";
import "package:duckyapp/utils/const/font_weight.dart";
import "package:duckyapp/utils/const/image.dart";
import "package:duckyapp/utils/const/note_text.dart";
import "package:duckyapp/utils/const/error_alert_dialog.dart";
import "package:duckyapp/utils/const/size/text_size.dart";
import "package:duckyapp/utils/routes/routes.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../../common/login_sign_up_widgets/email_text_field.dart";
import "../../../common/login_sign_up_widgets/error_dialog.dart";
import "../../../common/login_sign_up_widgets/footer_social_options.dart";
import "../../../common/login_sign_up_widgets/form_divider.dart";
import "../../../common/login_sign_up_widgets/login_sign_up_button.dart";
import "../../../common/login_sign_up_widgets/password_text_field.dart";
import "../../../utils/const/note_space.dart";
import "../../../utils/const/size/NImageSize.dart";
import "../../bloc/events.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthActionState || current is AuthErrorState,
      buildWhen: (previous, current) =>
          current is! AuthActionState && current is! AuthErrorState,

      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.profileView,
            (route) => false,
            arguments: state.currentUser
          );
        } else if (state is SignUpNavigationClickedActionState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signUp,
            (route) => false,
          );
        } else if (state is AuthErrorState) {
          if (state is UserDisabledState) {
            showDialog(
              context: context,
              builder: ((context) {
                return ErrorDialog(text: NText.userDisabled);
              }),
            );
          } else if (state is WrongPasswordState) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(text: NText.wrongPassword),
            );
          } else if (state is UserNotFoundState) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(text: NText.userNotFound),
            );
          } else {
            print(state.runtimeType);
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(text: NText.unknownError),
            );
          }
        }
      },

      builder: (context, state) {
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
                      Image(
                        image: AssetImage(NImage.noteLogo),
                        height: NImageSize.logoHeight,
                      ),
                      SizedBox(height: NSpace.spaceBtwTitleLogo),
                      // Title and subtitle
                      Text(
                        NText.loginTitle,
                        style: TextStyle(
                          fontWeight: NFontWeight.titleFontWeight,
                          fontSize: NTextSize.titleFontSize,
                        ),
                      ),
                      SizedBox(height: NSpace.spaceBtwTitleSubTit),
                      Text(
                        NText.loginSubtitle,
                        style: TextStyle(
                          fontSize: NTextSize.subTitleFontSize,
                          fontWeight: NFontWeight.subTitleFontWeight,
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
                        EmailTextField(controller: _emailController,),
                        // Password text field
                        SizedBox(height: NSpace.spaceBtwTextField),
                        PasswordTextField(controller: _passwordController,),
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
                          child: MainButton(
                            displayText: NText.login,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  LoginButtonClickedEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        // Sign up button
                        SizedBox(height: NSpace.spaceBtwItems / 2),
                        SizedBox(
                          height: NButtonSize.buttonHeight,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                SignUpNavigationClickedEvent(),
                              );
                            },
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
                            child: Text(
                              NText.signUp,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: NColors.black,
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
      },
    );
  }
}

void navigate() {}
