import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/routes/routes.dart';
import '../../bloc/bloc.dart';
import '../../bloc/states.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, Routes.profileView, arguments: state.currentUser);
        }
        else if (state is UserNotLogInState) {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
        else if (state is UserNotVerifiedActionState) {
          Navigator.pushReplacementNamed(context, Routes.verifyEmailWaiting);
        }
        else {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
